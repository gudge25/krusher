<?php

    function sipdb($ARG1, $ARG2, $link)
    {
        $file  = $ARG1."sip/db.conf";
        $file2 = $ARG1."extensions/db_office.ael";
        $file3 = $ARG1."extensions/db_base.ael";
        $file4 = $ARG1."extensions/db_transfer.ael";
        $result = c_mysqli_call($link, 'ast_GetSippeersEmploy', '');
        $result_Aid = c_mysqli_call($link, 'ast_GetEmployAidClear', '');

        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';
        $Aid = [];
        shell_exec("rm -f $file");
        shell_exec("rm -f $file2");
        shell_exec("rm -f $file3");
        shell_exec("rm -f $file4");
        if (count($result) > 0)
        {
            foreach ($result as $row)
                if(isset($row['sipName']))
                {
                    file_put_contents($file,"[".$row['sipName'].'_'.$row['Aid']."](".$row['template'].")\n"                                                     , FILE_APPEND);
                    if(strlen(trim($row['Name']))>0)        file_put_contents($file,"     nat=".$row['Name'].  "\n"                                             , FILE_APPEND);
                    if(strlen(trim($row['secret']))>0)      file_put_contents($file,"     secret=".$row['secret'].  "\n"                                        , FILE_APPEND);
                    if(strlen(trim($row['Aid']))>0)         file_put_contents($file,"     context=office_".$row['Aid']. "\n"                                    , FILE_APPEND);
                    if(strlen(trim($row['callgroup']))>0)   file_put_contents($file,"     callgroup=".$row['callgroup']. "\n"                                   , FILE_APPEND);
                    if(strlen(trim($row['pickupgroup']))>0) file_put_contents($file,"     pickupgroup=".$row['pickupgroup']. "\n"                               , FILE_APPEND);
                    if(strlen(trim($row['callerid']))>0)    file_put_contents($file,'     callerid="'.$row['emName']. '" <' .$row['sipName']. ">\n"             , FILE_APPEND);
                    if(strlen(trim($row['sipName']))>0)     file_put_contents($file,"     setvar=sip=".$row['sipName'].'_'.$row['Aid']."\n"                     , FILE_APPEND);
                    if(strlen(trim($row['emID']))>0)        file_put_contents($file,"     setvar=emID=".$row['emID']."\n"                                       , FILE_APPEND);
                    if(strlen(trim($row['Queue']))>0)       file_put_contents($file,"     setvar=Queue=".$row['Queue']."\n"                                     , FILE_APPEND);
                    if(strlen(trim($row['Aid']))>0)         file_put_contents($file,"     setvar=TRANSFER_CONTEXT=transfer_".$row['Aid']."\n"                   , FILE_APPEND);
                    if(strlen(trim($row['Aid']))>0)         file_put_contents($file,"     setvar=FORWARD_CONTEXT=transfer_".$row['Aid']."\n"                   , FILE_APPEND);
                    if(strlen(trim($row['emName']))>0)      file_put_contents($file,"     description=".$row['emName']."\n"                                     , FILE_APPEND);
                    if(strlen(trim($row['lines']))>0){
                                                            file_put_contents($file,"     busylevel=".$row['lines']."\n"                                        , FILE_APPEND);
                                                            file_put_contents($file,"     call-limit=".$row['lines']."\n"                                       , FILE_APPEND);
                    }
                    if (isset($row['dtmfmode']) && isset($row['dtmfmodeName']) && strlen(trim($row['dtmfmode'])) > 0 && strlen(trim($row['dtmfmodeName'])) > 0) file_put_contents($file, "     dtmfmode=" . $row['dtmfmodeName'] . "\n", FILE_APPEND);
                    if (isset($row['transport']) > 0 && strlen(trim($row['transport'])) > 0) {
                        unset($itemss);
                        $itemss = explode(',', $row['transport']);
                        foreach ($itemss as $inf) {
                            $itemsResult = c_mysqli_call($link, 'us_GetEnumClear', $row['Aid'] . ', ' . $inf . ', NULL, NULL, NULL, NULL, NULL, NULL, NULL');
                            $itemss['result'][] = $itemsResult[0]['Name'];
                        }
                        file_put_contents($file, "     transport=" . implode(',', $itemss['result']) . "\n", FILE_APPEND);
                    }

                    if (isset($row['encryption']) && strlen(trim($row['encryption'])) > 0) {
                        if ($row['encryption'] == TRUE)
                            file_put_contents($file, "     encryption=yes\n", FILE_APPEND);
                        else
                            file_put_contents($file, "     encryption=no\n", FILE_APPEND);
                    }

                    $Aid[$row['Aid']]['Aid'] = $row['Aid'];
                    $Aid[$row['Aid']]['TariffLimit'] = $row['TariffLimit'];
                    $Aid[$row['Aid']]['TariffDate'] = $row['TariffDate'];
                }

            foreach ($result_Aid as $value)
            {
                file_put_contents($file2,'context office_'.$value['Aid'].' {        includes { /*db_sip_'.$value['Aid'].'; db_queue_'.$value['Aid'].'; db_record_'.$value['Aid'].'; */  Base_'.$value['Aid'].'; }     };'."\n\n", FILE_APPEND);
                file_put_contents($file3,'abstract context Base_'.$value['Aid']." {\n", FILE_APPEND);
                file_put_contents($file3,'        _[+0-9_].      => '."{\n", FILE_APPEND);
                file_put_contents($file3,'                  MSet(Aid='.$value['Aid'], FILE_APPEND);
                if(isset($value['TariffLimit']) && strlen($value['TariffLimit'])>0)
                {
                    if((int)$value['TariffLimit'] < 5)
                        file_put_contents($file3,',TariffLimit=5', FILE_APPEND);
                    else
                        file_put_contents($file3,',TariffLimit='.$value['TariffLimit'], FILE_APPEND);
                }
                else
                    file_put_contents($file3,',TariffLimit=5', FILE_APPEND);
                if(isset($value['TariffDate']) && strlen($value['TariffDate'])>0)
                    file_put_contents($file3,',TariffDate="'.$value['TariffDate'].'"', FILE_APPEND);
                else
                    file_put_contents($file3,',TariffDate=null', FILE_APPEND);
                file_put_contents($file3,');'."\n", FILE_APPEND);
                file_put_contents($file3,'                  &abstractBase();'."\n", FILE_APPEND);
                file_put_contents($file3,'                  &clear(${EXTEN});'."\n", FILE_APPEND);
                file_put_contents($file3,'                  &volume(1);'."\n\n", FILE_APPEND);
                file_put_contents($file3,'                //Recording file'."\n", FILE_APPEND);
                file_put_contents($file3,'                  &mix_krusher();'."\n", FILE_APPEND);

                $query = "SELECT sipName 
                            FROM ast_sippeers 
                            WHERE isActive = TRUE AND 
                                    Aid = ".$value['Aid']." AND
                                    emID IN (SELECT emID FROM emEmploy WHERE isActive = TRUE AND Aid = ".$value['Aid'].");";
                $result = mysqli_query($link, $query) or die("Query fail: " . mysqli_error($link));
                unset($sips);
                while ($row = mysqli_fetch_array($result)) {
                    $sips[] = $row['sipName'];
                    $sips[] = $row['sipName'].'_'.$value['Aid'];
                }
                if (isset($sips) && count($sips))
                {
                    file_put_contents($file3,'                //Local Calls'."\n", FILE_APPEND);
                    file_put_contents($file3,'                  if( ${REGEX("^('.implode('|', $sips).')$" ${ccName})} == 1 && "${BLINDTRANSFER}" == "") CallType=101320; '."\n"        , FILE_APPEND);
                }

                file_put_contents($file3,'                //First CallingCard'."\n", FILE_APPEND);
                file_put_contents($file3,'                  &postCallincard();'."\n\n", FILE_APPEND);

                $result = c_mysqli_call($link, 'ast_GetScenarioClear', $value['Aid']. ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, NULL, NULL, NULL, NULL');
                //$if = true;
                foreach ($result as $scenario)
                {
                    if(isset($scenario['roIDs']) && strlen(trim($scenario['roIDs']))>0)
                    {
                        file_put_contents($file3,'                  if("${isAutoCall}" == "true" & "${id_scenario}" != "" && "${id_scenario}" != "null" & "${roIDs}" != "" & "${roIDs}" != "null") { goto route_scenario_${id_scenario}_'.$scenario['Aid'].'|${ccName}|1; Hangup; }'."\n", FILE_APPEND);
                        break;
                    }
                }
                file_put_contents($file3,'                  goto route_'.$value['Aid'].'|${ccName}|1;'."\n", FILE_APPEND);
                file_put_contents($file3,'                  Hangup;'."\n", FILE_APPEND);
                file_put_contents($file3,'        }'."\n", FILE_APPEND);
                file_put_contents($file3,"}\n\n", FILE_APPEND);
            }

            foreach ($result_Aid as $value)
            {
                file_put_contents($file4, 'context transfer_' . $value['Aid'] . ' {'. "\n", FILE_APPEND);
                file_put_contents($file4, '     _X. => { Set(sipClean=${CUT(BLINDTRANSFER,-,1)}); Set(sipClean2=${CUT(sipClean,/,2)}); Set(sip=${CUT(sipClean2,_,1)}); Mset(transferFrom=[${QUOTE(${sip})}],transferTo=[${QUOTE(${EXTEN})}]); goto route_' . $value['Aid'] . '|${EXTEN}|1; Hangup; } ' . "\n", FILE_APPEND);
                file_put_contents($file4, '}' . "\n\n", FILE_APPEND);
            }

            echo 'sipdb: created "'.$file .'"'."\n";
            echo 'office.ael: created "'.$file2 .'"'."\n";
            echo 'base.ael: created "'.$file3 .'"'."\n";
            echo 'transfer.ael: created "'.$file4 .'"'."\n";

            if(file_exists($file))
                $out_data = file($file);
            else
                $out_data = '';
            return checkFile($ARG2."asterisk -rx 'sip reload'", $in_data, $out_data);
        }
        else
            return 'no changes';
    }

?>


