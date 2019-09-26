<?php
    require_once 'settings.php';
    require_once 'functions.php';
    $sleepTime = 10;
    $working = true;
    $path = '/var/www/html/hapi/log/sms';
    $context = stream_context_create([
        'http' => ['ignore_errors' => true],
    ]);
    $info['user'] = exec('source ~/.bashrc && whoami');
    $info['DB_PRD_HOST'] = exec('source ~/.bashrc && echo ${DB_PRD_HOST}');
    $info['DB_PRD_USER'] = exec('source ~/.bashrc && echo ${DB_PRD_USER}');
    $info['DB_PRD_PASS'] = exec('source ~/.bashrc && echo ${DB_PRD_PASS}');
    $info['DB_PRD_NAME'] = exec('source ~/.bashrc && echo ${DB_PRD_NAME}');
    $mysql_link = mysqli_connect($info['DB_PRD_HOST'], $info['DB_PRD_USER'], $info['DB_PRD_PASS']);
    mysqli_set_charset($mysql_link, 'utf8' );
    mysqli_select_db($mysql_link, $info['DB_PRD_NAME']);

    file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($mysql_link, true)."\r\n", FILE_APPEND);
    if(!$mysql_link)
        exit('MySQL сould not be connected');
    file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($info, true)."\r\n", FILE_APPEND);

    while($working)
    {
        $query = 'SELECT dcID, Aid, emID, timeSend, originator, phone, text_sms, statusSms, isActive, Created, Changed FROM cc_Sms
                    WHERE statusSms = 7012 AND isActive = TRUE AND Aid IN (SELECT Aid FROM mp_IntegrationInstall WHERE mpID = 1 AND isActive = TRUE)
                    LIMIT 10;';
        file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($query, true)."\r\n", FILE_APPEND);
        $smsListDB = $mysql_link->query($query);
        file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsListDB, true)."\r\n", FILE_APPEND);
        unset($smsList);
        unset($smsSupplier);
        foreach ($smsListDB as $data)
        {
            $smsList['sms'][$data['dcID']] = $data;
            $smsSupplier['list'][] = $data['Aid'];
        }
        file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsList, true)."\r\n", FILE_APPEND);
        file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsSupplier, true)."\r\n", FILE_APPEND);
        if(isset($smsList['sms']) && count($smsList['sms'])>0)
        {
            file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsList['sms'], true)."\r\n", FILE_APPEND);
            $query = 'UPDATE cc_Sms SET statusSms = 7013 WHERE dcID IN ('.(implode(', ', array_keys($smsList['sms']))).');';
            $mysql_link->query($query);
            $smsSupplier['unique'] = array_unique($smsSupplier['list']);
            $query = 'SELECT mpiID, Aid, mpID, login, pass, token, link, settings, isActive, Created, Changed FROM mp_IntegrationInstall WHERE Aid IN ('.implode(', ', $smsSupplier['unique']).') AND mpID = 1 AND isActive = TRUE;';
            $supplierList = $mysql_link->query($query);
            foreach ($supplierList as $data)
            {
                $smsList['supplier'][$data['Aid']] = $data;
                $smsSupplier[] = $data['Aid'];
            }
            file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsList['supplier'], true)."\r\n", FILE_APPEND);
            foreach ($smsList['sms'] as $sending)
            {
                $url = $smsList['supplier'][$sending['Aid']]['link'];
                $url .= '?';
                $url .= 'token='.$smsList['supplier'][$sending['Aid']]['token'];
                $url .= '&phone='.$sending['phone'];
                if(strlen(trim($sending['originator'])))
                    $url .= '&senderID='.trim($sending['originator']);
                else
                {
                    $settings = json_decode($smsList['supplier'][$sending['Aid']]['settings']);
                    if(isset($settings->sender))
                    {
                        $url .= '&senderID='.$settings->sender;
                        $sending['originator'] = $settings->sender;
                    }
                    else
                    {
                        $url .= '&senderID=Unknown';
                        $sending['originator'] = 'Unknown';
                    }
                }
                $url .= '&text='.addslashes($sending['text_sms']);
                file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | url:'.$url."\r\n", FILE_APPEND);
                $result = json_decode(file_get_contents($url, false, $context));
                file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($result, true)."\r\n", FILE_APPEND);
                if(isset($result->error))
                {
                    $query = 'UPDATE cc_Sms SET originator = "'.$sending['originator'].'", statusSms = 7004 WHERE dcID = '.$sending['dcID'].';';
                    file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.$query."\r\n", FILE_APPEND);
                    $mysql_link->query($query);
                }
                else
                {
                    $query = 'UPDATE cc_Sms SET originator = "'.$sending['originator'].'", statusSms = 7013 WHERE dcID = '.$sending['dcID'].';';
                    file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.$query."\r\n", FILE_APPEND);
                    $mysql_link->query($query);
                    $query = 'UPDATE ccContact SET ccStatus = 7013 WHERE dcID  = '.$sending['dcID'].';';
                    file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.$query."\r\n", FILE_APPEND);
                    $mysql_link->query($query);
                    if(is_array($result->{$sending['phone']}))
                    {
                        $i = 1;
                        foreach ($result->{$sending['phone']} as $part)
                        {
                            $query = 'INSERT INTO `krusher`.`cc_SmsParts` (`dcID`, `part_num`, `supplier_id`, `supplier_part_id`) VALUES ('.$sending['dcID'].', '.$i.', '.$smsList['supplier'][$sending['Aid']]['mpiID'].', "'.$part->id_state.'");';
                            file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.$query."\r\n", FILE_APPEND);
                            $mysql_link->query($query);
                            $i++;
                        }
                    }
                    else
                    {
                        $query = 'INSERT INTO `krusher`.`cc_SmsParts` (`dcID`, `part_num`, `supplier_id`, `supplier_part_id`) VALUES ('.$sending['dcID'].', 1, '.$smsList['supplier'][$sending['Aid']]['mpiID'].', "'.$result->{$sending['phone']}.'");';
                        file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.$query."\r\n", FILE_APPEND);
                        $mysql_link->query($query);
                    }
                }
            }
        }
        else
        {
            file_put_contents($path . '/sms_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | sleep '.$sleepTime.' sec'."\r\n", FILE_APPEND);
            sleep(10);
        }
    }
    echo 'Gone'."\r\n";

?>