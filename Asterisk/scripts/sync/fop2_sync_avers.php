<?php
    function fop2_sync($ARG1, $ARG2, $link)
    {
        $file = $ARG1 . "buttons_custom.cfg";
        $file2 = $ARG1 . "fop2.cfg";

        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        file_put_contents($file, '');
        file_put_contents($file2, '');

        if (file_exists($file))
        {
            //FILE
            $result = mysqli_query($link, "SELECT * FROM ast_queues WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY Aid, queID;") or die("Query fail: " . mysqli_error($link));
            //QUEUE
            while ($row = mysqli_fetch_array($result)) {
                file_put_contents($file,'[QUEUE/' . $row['queID'] . ']'."\n"        , FILE_APPEND);
                file_put_contents($file,'type=queue'."\n"        , FILE_APPEND);
                file_put_contents($file,'extension=' . $row['queID']."\n"        , FILE_APPEND);
                file_put_contents($file,'context=db_queue_'.$row['Aid']."\n"        , FILE_APPEND);
                file_put_contents($file,'label=' . $row['name'] ."\n"        , FILE_APPEND);
                file_put_contents($file,"\n"        , FILE_APPEND);
            }

            $result = mysqli_query($link, "SELECT a.Aid, a.sipName, a.context, b.emName, b.Queue/*, q.name*/
                                                FROM ast_sippeers as a
                                                LEFT JOIN emEmploy as b ON a.sipID = b.sipID
                                                WHERE a.isActive = TRUE AND a.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) /*AND q.isActive = TRUE*/
                                                ORDER BY b.sipName;") or die("Query fail: " . mysqli_error($link));
            //SIP USERS
            while ($row = mysqli_fetch_array($result))
            {
                file_put_contents($file,'[SIP/' . $row['sipName'] .'_'.$row['Aid']. ']' ."\n"        , FILE_APPEND);
                file_put_contents($file,'type=extension' ."\n"        , FILE_APPEND);
                file_put_contents($file,'extension=' . $row['sipName'].'_'.$row['Aid'] ."\n"        , FILE_APPEND);
                file_put_contents($file,'context=' . $row['context'] ."\n"        , FILE_APPEND);
                file_put_contents($file,'label=' . $row['emName']  ."\n"        , FILE_APPEND);
                /*if(strlen($row['name'] )>0)
                    file_put_contents($file, 'group=' . $row['name'] ."\n"        , FILE_APPEND);*/
                file_put_contents($file,"\n"        , FILE_APPEND);
            }

            $result = mysqli_query($link, "SELECT * FROM ast_trunk WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY trID;") or die("Query fail: " . mysqli_error($link));
            //TRUNK
            while ($row = mysqli_fetch_array($result)) {
                file_put_contents($file,'[SIP/' . $row['trName'] .'_'. $row['Aid']. ']' ."\n"        , FILE_APPEND);
                file_put_contents($file,'type=trunk' ."\n"        , FILE_APPEND);
                file_put_contents($file,'context=' . $row['context'] ."\n"        , FILE_APPEND);
                if(($row['coID'] !=0 ) && (strlen($row['coID'])>0))
                {
                    $result2 = c_mysqli_call($link, 'crm_GetCompanyClear', $row['coID'].', NULL, NULL, NULL, NULL, NULL, NULL, NULL');
                    if(count($result2)>0)
                    {
                        file_put_contents($file,'label='.$row['trName'].'/'. $result2[0]['coName']  ."\n"        , FILE_APPEND);
                    }
                    else
                        file_put_contents($file,'label=' . $row['trName']  ."\n"        , FILE_APPEND);
                }
                else
                    file_put_contents($file,'label=' . $row['trName']  ."\n"        , FILE_APPEND);
                file_put_contents($file,"\n"        , FILE_APPEND);
            }

            $result = mysqli_query($link, "SELECT * FROM ast_conference c 
                                                    WHERE c.isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ;") or die("Query fail: " . mysqli_error($link));
            //Conference
            while ($row = mysqli_fetch_array($result)) {
                file_put_contents($file,'[CONFERENCE/' . $row['cfID']. ']' ."\n"        , FILE_APPEND);
                file_put_contents($file,'type=conference' ."\n"        , FILE_APPEND);
                file_put_contents($file,'context=db_conference_'. $row['Aid'] ."\n"        , FILE_APPEND);
                file_put_contents($file,'extension='. $row['cfID'] ."\n"        , FILE_APPEND);
                file_put_contents($file,'label=' . $row['cfName']  ."\n"        , FILE_APPEND);
                file_put_contents($file,"\n"        , FILE_APPEND);
            }

            file_put_contents($file2,'[general]'."\n"        , FILE_APPEND);
            file_put_contents($file2,'manager_host=localhost'."\n"        , FILE_APPEND);
            file_put_contents($file2,'manager_port=5039' ."\n"       , FILE_APPEND);
            file_put_contents($file2,'manager_user=fop2' ."\n"       , FILE_APPEND);
            file_put_contents($file2,'manager_secret=vee9wiegeeNgoo2xid5ataeN7ahtho2asd'."\n"        , FILE_APPEND);
            file_put_contents($file2,'' ."\n"       , FILE_APPEND);
            file_put_contents($file2,'web_dir = /var/www/html/fop2'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'listen_ip        = 0.0.0.0'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'listen_port	 = 4445' ."\n"       , FILE_APPEND);
            file_put_contents($file2,'poll_interval	   = 86400'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'poll_voicemail     = 1'   ."\n"     , FILE_APPEND);
            file_put_contents($file2,'monitor_ipaddress  = 0'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'blind_transfer     = 0'   ."\n"     , FILE_APPEND);
            file_put_contents($file2,'supervised_transfer = 1'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'        ;master_key = 5678'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'spy_options="bq"'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'whisper_options="w"'  ."\n"      , FILE_APPEND);
            file_put_contents($file2,'        monitor_filename=/var/spool/asterisk/monitor/${ORIG_EXTENSION}_${DEST_EXTENSION}_%h%i%s_${UNIQUEID}_${FOP2CONTEXT}'     ."\n"   , FILE_APPEND);
            file_put_contents($file2,'monitor_format=wav'     ."\n"   , FILE_APPEND);
            file_put_contents($file2,'monitor_mix=true'    ."\n"    , FILE_APPEND);
            file_put_contents($file2,'voicemail_path=/var/spool/asterisk/voicemail'    ."\n"    , FILE_APPEND);
            file_put_contents($file2,'        sms_enable_messagesend=1'    ."\n"    , FILE_APPEND);
            file_put_contents($file2,' buttonfile=buttons_custom.cfg' ."\n"       , FILE_APPEND);
            file_put_contents($file2,''    ."\n"    , FILE_APPEND);
            file_put_contents($file2,'ssl_certificate_file=/var/www/html/hapi/keys/cert.pem'     ."\n"   , FILE_APPEND);
            file_put_contents($file2,'ssl_certificate_key_file=/var/www/html/hapi/keys/privkey.pem'."\n"        , FILE_APPEND);

            //$query = "SELECT * FROM emClient WHERE isActive=TRUE ORDER BY id_client;";
            $query = "SELECT DISTINCT ManageID FROM emEmploy WHERE ManageID IS NOT NULL;";
            $result = mysqli_query($link, $query) or die("Query fail: " . mysqli_error($link));
            $list = $domain = $list2 = $list3 = $list4 = $list5 = [];
            while ($row = mysqli_fetch_array($result))
            {
                $list[$row['ManageID']] = $row['ManageID'];
            }

            foreach ($list as $key => $item)
            {
                unset($list2);
                unset($list3);
                unset($list4);
                unset($list5);
                $list2 = $list3 = $list4 = [];
                //$query = "SELECT queID FROM ast_queues WHERE Aid=".$key." AND isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY queID;";
                $query = "SELECT queID 
                            FROM ast_queues 
                            WHERE Aid IN (SELECT Aid FROM emEmploy WHERE emID = ".$key." AND isActive = TRUE) 
                                AND isActive = TRUE 
                                AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) 
                                AND queID IN (SELECT queID FROM ast_queue_members WHERE isActive = TRUE AND emID IN (SELECT emID FROM emEmploy WHERE (ManageID = ".$key." OR emID = ".$key."))) 
                            ORDER BY queID;";
                //echo $query."\r\n";
                $result2 = mysqli_query($link, $query) or die("Query fail1: " . mysqli_error($link));
                while ($row = mysqli_fetch_array($result2))
                    $list2[] = 'QUEUE/'.$row['queID'];
                //$query = "SELECT sipID, Aid, sipName FROM ast_sippeers WHERE Aid=".$key." AND isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY sipID;";
                $query = "SELECT sipID, Aid, sipName 
                            FROM ast_sippeers 
                            WHERE Aid IN (SELECT Aid FROM emEmploy WHERE emID = ".$key." AND isActive = TRUE) 
                                AND isActive = TRUE 
                                AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) 
                                AND emID IN (SELECT emID FROM emEmploy WHERE (ManageID = ".$key." OR emID = ".$key."))
                            ORDER BY sipID;";
                //echo $query."\r\n";
                $result2 = mysqli_query($link, $query) or die("Query fail2: " . mysqli_error($link));
                while ($row = mysqli_fetch_array($result2))
                    $list3[] = 'SIP/'.$row['sipName'].'_'.$row['Aid'];
                $query = "SELECT trID, Aid, trName, uniqName FROM ast_trunk WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY trID;";
                //echo $query."\r\n";
                $result2 = mysqli_query($link, $query) or die("Query fail3: " . mysqli_error($link));
                while ($row = mysqli_fetch_array($result2))
                    $list4[] = 'SIP/'.$row['uniqName'];
                /*$query = "SELECT * FROM ast_conference c
                            WHERE c.isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) AND Aid = ".$key." ;";*/
                $query = "SELECT * FROM ast_conference c 
                            WHERE c.isActive = TRUE 
                                AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) 
                                AND Aid IN (SELECT Aid FROM emEmploy WHERE emID = ".$key." AND isActive = TRUE) 
                                AND cfID IN (SELECT destdata FROM ast_route_outgoing WHERE roID IN (SELECT roID FROM ast_route_outgoing_items WHERE callerID IN (SELECT sipName FROM ast_sippeers WHERE emID IN (SELECT emID FROM emEmploy WHERE (ManageID = ".$key." OR emID = ".$key.")))) AND destination=101412);";
                //echo $query."\r\n";
                $result2 = mysqli_query($link, $query) or die("Query fail3: " . mysqli_error($link));
                while ($row = mysqli_fetch_array($result2))
                    $list5[] = 'CONFERENCE/'.$row['cfID'];
                if(isset($list5) && count($list5)>0)
                    $list2 = array_merge($list2, $list5);
                if(isset($list4) && count($list4)>0)
                    $list2 = array_merge($list2, $list4);
                if(isset($list4) && count($list3)>0)
                    $list2 = array_merge($list2, $list3);
                if(isset($list2) && count($list2)>0)
                    file_put_contents($file2,'  group='.$item.':'.implode(',', (isset($list2) ? $list2 : []))."\n"        , FILE_APPEND);
                //exit();
            }
            file_put_contents($file2,"\n"        , FILE_APPEND);
            foreach ($list as $key => $item)
            {
                /*$query = "SELECT sipID, Aid, sipName, MD5(secret)  secret
                          FROM ast_sippeers 
                          WHERE Aid=".$key." AND emID IN (SELECT emID FROM emEmploy WHERE roleID IN (SELECT roleID FROM emRole WHERE Permission IN (1, 2) AND Aid=".$key.") AND Aid=".$key.") AND isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE)
                          ORDER BY sipID;";*/
                $query = "SELECT sipID, Aid, sipName, MD5(secret)  secret
                            FROM ast_sippeers 
                            WHERE Aid IN (SELECT Aid FROM emEmploy WHERE emID = ".$key." AND isActive = TRUE)  
                                AND emID = ".$key."
                                AND isActive = TRUE 
                                AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE)
                            ORDER BY sipID;";
                $result3 = mysqli_query($link, $query) or die("Query fail4: " . mysqli_error($link));
                unset($list3);
                while ($row = mysqli_fetch_array($result3))
                    file_put_contents($file2,'  user='.$row['sipName'].'_'.$row['Aid'].':'.$row['secret'].':all:'.$item."\n"        , FILE_APPEND);
                $query = "SELECT sipID, Aid, sipName, MD5(secret)  secret
                            FROM ast_sippeers 
                            WHERE Aid IN (SELECT Aid FROM emEmploy WHERE emID = ".$key." AND isActive = TRUE)  
                                 AND emID IN (SELECT emID FROM emEmploy WHERE roleID IN (SELECT roleID FROM emRole WHERE Permission IN (2)) AND ManageID = ".$key.")
                                 AND isActive = TRUE 
                                 AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE)
                             ORDER BY sipID;";
                echo $query."\r\n";
                $result3 = mysqli_query($link, $query) or die("Query fail4: " . mysqli_error($link));
                unset($list3);
                while ($row = mysqli_fetch_array($result3))
                    file_put_contents($file2,'  user='.$row['sipName'].'_'.$row['Aid'].':'.$row['secret'].':all:'.$item."\n"        , FILE_APPEND);
            }
            //for admins
            unset($list2);
            unset($list3);
            unset($list4);
            unset($list5);
            $list2 = $list3 = $list4 = [];
            $query = "SELECT queID FROM ast_queues WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY queID;";
            //echo $query."\r\n";
            $result2 = mysqli_query($link, $query) or die("Query fail1: " . mysqli_error($link));
            while ($row = mysqli_fetch_array($result2))
                $list2[] = 'QUEUE/'.$row['queID'];
            $query = "SELECT sipID, Aid, sipName FROM ast_sippeers WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY sipID;";
            //echo $query."\r\n";
            $result2 = mysqli_query($link, $query) or die("Query fail2: " . mysqli_error($link));
            while ($row = mysqli_fetch_array($result2))
                $list3[] = 'SIP/'.$row['sipName'].'_'.$row['Aid'];
            $query = "SELECT trID, Aid, trName, uniqName FROM ast_trunk WHERE isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY trID;";
            //echo $query."\r\n";
            $result2 = mysqli_query($link, $query) or die("Query fail3: " . mysqli_error($link));
            while ($row = mysqli_fetch_array($result2))
                $list4[] = 'SIP/'.$row['uniqName'];
            $query = "SELECT * FROM ast_conference c
                        WHERE c.isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE);";
            //echo $query."\r\n";
            $result2 = mysqli_query($link, $query) or die("Query fail3: " . mysqli_error($link));
            while ($row = mysqli_fetch_array($result2))
                $list5[] = 'CONFERENCE/'.$row['cfID'];
            if(isset($list5) && count($list5)>0)
                $list2 = array_merge($list2, $list5);
            if(isset($list4) && count($list4)>0)
                $list2 = array_merge($list2, $list4);
            if(isset($list4) && count($list3)>0)
                $list2 = array_merge($list2, $list3);
            if(isset($list2) && count($list2)>0)
                file_put_contents($file2,'  group=admins:'.implode(',', (isset($list2) ? $list2 : []))."\n"        , FILE_APPEND);
            file_put_contents($file2,"\n"        , FILE_APPEND);

            $query = "SELECT sipID, Aid, sipName, MD5(secret)  secret
                      FROM ast_sippeers
                      WHERE emID IN (SELECT emID FROM emEmploy WHERE roleID IN (SELECT roleID FROM emRole WHERE Permission IN (1))) AND isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE)
                      ORDER BY sipID;";

            $result3 = mysqli_query($link, $query) or die("Query fail4: " . mysqli_error($link));
            unset($list3);
            while ($row = mysqli_fetch_array($result3))
                file_put_contents($file2,'  user='.$row['sipName'].'_'.$row['Aid'].':'.$row['secret'].':all:admins'."\n"        , FILE_APPEND);
            if(file_exists($file))
                $out_data = file($file);
            mysqli_next_result($link);
            mysqli_free_result($result);
            echo 'fop2_sync: created "'.$file .'"'."\n";
            return checkFile($ARG2 . "service fop2 restart", $in_data, $out_data);
        } else {
            echo "fop2_sync: File does not exist.\n";
            return checkFile($ARG2 . "service fop2 restart", $in_data, $out_data);
        }
    }
?>