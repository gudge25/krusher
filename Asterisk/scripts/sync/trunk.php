<?php

    function trunkdb($ARG1, $ARG2, $link)
    {
        $file   = $ARG1."sip/db_trunk.conf";
        $result = c_mysqli_call($link, 'ast_GetTrunkClear', 'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, NULL, NULL, 0, 10000');

        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';
        shell_exec("rm -f $file");
        if (count($result) > 0)
        {
            foreach ($result as $row)
            {
                $name = $row['trName'].'_'.$row['Aid'];
                file_put_contents($file,"[".$name."](".$row['template'].")\n"                     , FILE_APPEND);
                if((strlen($row['secret'])>0) && (trim($row['secret'])!='NULL'))                        file_put_contents($file,"     secret               = ".$row['secret'].  "\n"                , FILE_APPEND);
                if((strlen($row['defaultuser'])>0) && (trim($row['defaultuser'])!='NULL'))              file_put_contents($file,"     defaultuser          = ".$row['defaultuser']. "\n"            , FILE_APPEND);
                if((strlen($row['context'])>0) && (trim($row['context'])!='NULL'))                      file_put_contents($file,"     context              = ".$row['context']. "\n"                , FILE_APPEND);
                if((strlen($row['callgroup'])>0) && (trim($row['callgroup'])!='NULL'))                  file_put_contents($file,"     callgroup            = ".$row['callgroup']. "\n"              , FILE_APPEND);
                if((strlen($row['pickupgroup'])>0) && (trim($row['pickupgroup'])!='NULL'))              file_put_contents($file,"     pickupgroup          = ".$row['pickupgroup']. "\n"            , FILE_APPEND);
                if((strlen($row['host'])>0) && (trim($row['host'])!='NULL'))                            file_put_contents($file,"     host                 = ".$row['host']. "\n"                   , FILE_APPEND);
                if((strlen($row['fromdomain'])>0) && (trim($row['fromdomain'])!='NULL'))                file_put_contents($file,"     fromdomain           = ".$row['fromdomain']. "\n"             , FILE_APPEND);
                if((strlen($row['fromuser'])>0) && (trim($row['fromuser'])!='NULL'))                    file_put_contents($file,"     fromuser             = ".$row['fromuser']. "\n"               , FILE_APPEND);
                if((strlen($row['callbackextension'])>0) && (trim($row['callbackextension'])!='NULL'))  file_put_contents($file,"     callbackextension    = ".$row['callbackextension']. "\n"      , FILE_APPEND);
                if((strlen($row['nat'])>0) && (trim($row['nat'])!='NULL'))                              file_put_contents($file,"     nat                  = ".$row['nat']. "\n"                    , FILE_APPEND);
                if((strlen($row['outboundproxy'])>0) && (trim($row['outboundproxy'])!='NULL'))          file_put_contents($file,"     outboundproxy        = ".$row['outboundproxy']."\n"           , FILE_APPEND);
                if((strlen($row['port'])>0) && (trim($row['port'])!='NULL'))                            file_put_contents($file,"     port                 = ".$row['port']."\n"                    , FILE_APPEND);
                if((strlen($row['type'])>0) && (trim($row['type'])!='NULL'))                            file_put_contents($file,"     type                 = ".$row['type']. "\n"                   , FILE_APPEND);
                if((strlen($row['directmedia'])>0) && (trim($row['directmedia'])!='NULL'))              file_put_contents($file,"     directmedia          = ".$row['directmedia']. "\n"            , FILE_APPEND);
                if((strlen($row['insecure'])>0) && (trim($row['insecure'])!='NULL'))                    file_put_contents($file,"     insecure             = ".$row['insecure']. "\n"               , FILE_APPEND);
                if((strlen($row['trName'])>0) && (trim($row['trName'])!='NULL'))                        file_put_contents($file,"     setvar=channel=".$row['trName']."\n"                          , FILE_APPEND);
                if((strlen($row['coID'])>0) && (trim($row['coID'])!='NULL'))                            file_put_contents($file,"     setvar=coID=".$row['coID']."\n"                               , FILE_APPEND);
                if((strlen($row['coName'])>0) && (trim($row['coName'])!='NULL'))                        file_put_contents($file,"     setvar=coName=".$row['coName']."\n"                           , FILE_APPEND);
                if(strlen(trim($row['Aid']))>0)                                                         file_put_contents($file,"     setvar=TRANSFER_CONTEXT=transfer_".$row['Aid']."\n"           , FILE_APPEND);
                if(strlen(trim($row['Aid']))>0)                                                         file_put_contents($file,"     setvar=FORWARD_CONTEXT=transfer_".$row['Aid']."\n"            , FILE_APPEND);

                if(strlen(trim($row['lines']))>0 && (trim($row['lines'])!='NULL'))                      file_put_contents($file,"     busylevel            =".$row['lines']."\n"                    , FILE_APPEND);
                if(strlen(trim($row['lines']))>0 && (trim($row['lines'])!='NULL') )                     file_put_contents($file,"     call-limit           =".$row['lines']."\n"                    , FILE_APPEND);
                if (strlen(trim($row['dtmfmode'])) > 0 && (trim($row['dtmfmode']) != 'NULL') && strlen(trim($row['dtmfmodeName'])) > 0) file_put_contents($file, "     dtmfmode             =" . $row['dtmfmodeName'] . "\n", FILE_APPEND);
                if (isset($row['transport']) > 0 && strlen(trim($row['transport'])) > 0)  {
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
            }

            echo 'trunkdb: created "'.$file .'"'."\n";
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