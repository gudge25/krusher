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
        $query = 'SELECT bulkID
                    , Aid
                    , originator
                    , ffID
                    , text_sms
                    , timeBegin
                    , emID
                    , `status`
                    , isActive
                    , Created
                    , Changed
                    FROM cc_SmsBulk
                    WHERE `status` = 103801 AND isActive = TRUE
                    LIMIT 1;';
        file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | query: '.$query."\r\n", FILE_APPEND);
        echo $query;
        $bulkListDB_all = $mysql_link->query($query);
        foreach ($bulkListDB_all as $item) {
            $bulkListDB = $item;
            break;
        }
        //print_r($bulkListDB);
        if(isset($bulkListDB) && count($bulkListDB)>0 /*&& is_int($bulkListDB['ffID'])*/)
        {
            file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | BULK: '.print_r($bulkListDB, TRUE)."\r\n", FILE_APPEND);
            $query = 'UPDATE cc_SmsBulk SET status = 103802 WHERE bulkID = '.$bulkListDB['bulkID'].';';
            file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | query: '.$query."\r\n", FILE_APPEND);
            $mysql_link->query($query);
            $query = 'SELECT c.clName `Name`
                                , c.`Comment` Comments
                                , c.CompanyID CompanyID
                                , (IF(ex.curID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.curID AND Aid = c.Aid AND isActive = TRUE LIMIT 1), NULL)) currency
                                , (IF(ex.langID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = ex.langID AND Aid = c.Aid AND isActive = TRUE LIMIT 1), NULL)) `language`
                                , ex.sum `sum`
                                , ex.ttsText tts
                                , o.TaxCode INN
                                , co.ccName phone  
                                , c.clID clID
                                , co.ccID ccID
                        FROM crmClient  c
                        INNER JOIN crmContact co ON (co.clID=c.clID AND co.ccType = 36 AND MCC IS NOT NULL)
                        INNER JOIN crmClientEx ex ON ex.clID=c.clID
                        INNER JOIN crmOrg o ON o.clID = c.clID
                        WHERE c.ffID = '.$bulkListDB['ffID'].' AND c.Aid = '.$bulkListDB['Aid'].';';
            file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | query: '.$query."\r\n", FILE_APPEND);
            echo $query;
            $smsListDB = $mysql_link->query($query);
            print_r($smsListDB);

            foreach ($smsListDB as $data)
            {
                print_r($data);
                file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | contact: '.print_r($data, TRUE)."\r\n", FILE_APPEND);
                $text_sms = $bulkListDB['text_sms'];
                foreach ($data as $key => $value)
                    $text_sms = str_replace('{{'.$key.'}}', $value, $text_sms);
                echo $text_sms."\r\n";
                file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | text: '.$text_sms."\r\n", FILE_APPEND);
                c_mysqli_call($mysql_link, 'ast_InsSingleSmsClear', $bulkListDB['Aid'].', '.$bulkListDB['bulkID'].', NULL, '.$bulkListDB['emID'].', '.$data['ccID'].', '.$data['clID'].', '.$bulkListDB['ffID'].', "'.$bulkListDB['originator'].'", '.$data['phone'].', "'.addslashes($text_sms).'", TRUE');
            }
            $query = 'UPDATE cc_SmsBulk SET status = 103803 WHERE bulkID = '.$bulkListDB['bulkID'].';';
            file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | query: '.$query."\r\n", FILE_APPEND);
            $mysql_link->query($query);
        }
        else
        {
            file_put_contents($path . '/bulk_parser_'.date("Y-m-d").'.log', date("Y-m-d H:i:s").' | sleep '.$sleepTime.' sec'."\r\n", FILE_APPEND);
            sleep(10);
        }
    }
    echo 'Gone'."\r\n";

?>