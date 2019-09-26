<?php
    require_once 'settings.php';
    require_once 'functions.php';
    $sleepTime = 10;
    $path = '/var/www/html/hapi/log/sms';
    $context = stream_context_create([
        'http' => ['ignore_errors' => true],
    ]);
    $info[] = exec('source ~/.bashrc && whoami');
    $info['DB_PRD_HOST'] = exec('source ~/.bashrc && echo ${DB_PRD_HOST}');
    $info['DB_PRD_USER'] = exec('source ~/.bashrc && echo ${DB_PRD_USER}');
    $info['DB_PRD_PASS'] = exec('source ~/.bashrc && echo ${DB_PRD_PASS}');
    $info['DB_PRD_NAME'] = exec('source ~/.bashrc && echo ${DB_PRD_NAME}');
    $mysql_link = mysqli_connect($info['DB_PRD_HOST'], $info['DB_PRD_USER'], $info['DB_PRD_PASS']);
    mysqli_set_charset($mysql_link, 'utf8' );
    mysqli_select_db($mysql_link, $info['DB_PRD_NAME']);

    if(!$mysql_link)
        exit('MySQL сould not be connected');

    $working = TRUE;
    while($working)
    {
        $query = 'SELECT id_part, dcID, part_num, supplier_id, supplier_part_id FROM cc_SmsParts
                    WHERE statusDelivering = "SENT" 
                        AND supplier_part_id IS NOT NULL 
                        AND supplier_part_id != "" 
                        AND sentTime>(NOW() - INTERVAL 7 DAY)
                    ORDER BY id_part DESC;';
        //echo $query;
        $smsListDB = $mysql_link->query($query);
        unset($smsList);
        unset($smsSupplier);
        foreach ($smsListDB as $data)
        {
            $smsList['sms'][$data['id_part']] = $data;
            $smsSupplier['list'][] = $data['supplier_id'];
        }
        if(isset($smsList['sms']) && count($smsList['sms'])>0)
        {
            file_put_contents($path . '/status_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsList['sms'], true)."\r\n", FILE_APPEND);
            $smsSupplier['unique'] = array_unique($smsSupplier['list']);
            $query = 'SELECT mpiID, Aid, mpID, login, pass, token, link, settings, isActive, Created, Changed FROM mp_IntegrationInstall WHERE mpiID IN ('.implode(', ', $smsSupplier['unique']).') AND mpID = 1 AND isActive = TRUE;';
            $supplierList = $mysql_link->query($query);
            foreach ($supplierList as $data)
            {
                $smsList['supplier'][$data['mpiID']] = $data;
                $smsSupplier[] = $data['mpiID'];
            }
            file_put_contents($path . '/status_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($smsList['supplier'], true)."\r\n", FILE_APPEND);
            foreach ($smsList['sms'] as $sending)
            {
                //state?token=123456789012345678901234567890&states=2641185,5751,5750
                $url = $smsList['supplier'][$sending['supplier_id']]['link'];
                $url .= '/state?';
                $url .= 'token='.$smsList['supplier'][$sending['supplier_id']]['token'];
                $url .= '&states='.$sending['supplier_part_id'];
                file_put_contents($path . '/status_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | url:'.$url."\r\n", FILE_APPEND);
                $result = json_decode(file_get_contents($url, false, $context));
                file_put_contents($path . '/status_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | '.print_r($result, true)."\r\n", FILE_APPEND);
                if(isset($result) && isset($result->{$sending['supplier_part_id']}))
                {
                    $status = 'SENT';
                    if(isset($result->{$sending['supplier_part_id']}->id_state))
                    {
                        if($result->{$sending['supplier_part_id']}->id_state == 'UNDELIV')
                            $status = 'UNDELIVERED';
                        elseif($result->{$sending['supplier_part_id']}->id_state == 'DELIVRD')
                            $status = 'DELIVERED';
                        elseif($result->{$sending['supplier_part_id']}->id_state == 'EXPIRED')
                            $status = 'EXPIRED';
                    }
                    if($status != 'SENT')
                    {
                        $query = 'UPDATE cc_SmsParts SET statusDelivering="'.$status.'" WHERE id_part='.$sending['id_part'].';';
                        $mysql_link->query($query);
                        $query = 'SELECT (SELECT count(id_part) FROM cc_SmsParts WHERE dcID='.$sending['dcID'].') parts
                                , (SELECT count(id_part) FROM cc_SmsParts WHERE dcID='.$sending['dcID'].' AND statusDelivering != "SENT") parts_status
                                , (SELECT count(id_part) FROM cc_SmsParts WHERE dcID='.$sending['dcID'].' AND statusDelivering = "DELIVERED") parts_delivered
                                , (SELECT count(id_part) FROM cc_SmsParts WHERE dcID='.$sending['dcID'].' AND statusDelivering = "UNDELIVERED") parts_undelivered
                                , (SELECT count(id_part) FROM cc_SmsParts WHERE dcID='.$sending['dcID'].' AND statusDelivering = "EXPIRED") parts_expired;';
                        $result = $mysql_link->query($query)->fetch_assoc();
                        if($result['parts'] === $result['parts_status'])
                        {
                            if($result['parts'] === $result['parts_delivered'])
                            {
                                $query = 'UPDATE cc_Sms SET statusSms = 7014 WHERE dcID='.$sending['dcID'].' AND statusSms = 7013;';
                                $query2 = 'UPDATE ccContact SET ccStatus = 7014 WHERE dcID='.$sending['dcID'].' AND ccStatus = 7013;';
                                $query3 = 'UPDATE dcDoc SET ccStatus = 7014 WHERE dcID='.$sending['dcID'].' AND dcStatus = 7013;';
                            }
                            elseif($result['parts'] === $result['parts_expired'])
                            {
                                $query = 'UPDATE cc_Sms SET statusSms = 7016 WHERE dcID='.$sending['dcID'].' AND statusSms = 7013;';
                                $query2 = 'UPDATE ccContact SET ccStatus = 7016 WHERE dcID='.$sending['dcID'].' AND ccStatus = 7013;';
                                $query3 = 'UPDATE dcDoc SET ccStatus = 7016 WHERE dcID='.$sending['dcID'].' AND dcStatus = 7013;';
                            }
                            else
                            {
                                $query = 'UPDATE cc_Sms SET statusSms = 7015 WHERE dcID='.$sending['dcID'].' AND statusSms = 7013;';
                                $query2 = 'UPDATE ccContact SET ccStatus = 7015 WHERE dcID='.$sending['dcID'].' AND ccStatus = 7013;';
                                $query3 = 'UPDATE dcDoc SET ccStatus = 7015 WHERE dcID='.$sending['dcID'].' AND dcStatus = 7013;';
                            }

                            $mysql_link->query($query);
                            $mysql_link->query($query2);
                            $mysql_link->query($query3);
                        }
                    }
                }
            }
        }
        else
        {
            file_put_contents($path . '/status_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | sleep '.$sleepTime.' sec'."\r\n", FILE_APPEND);
            sleep(10);
        }
    }
    echo 'Gone'."\r\n";

?>