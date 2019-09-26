<?php

    function basedb($ARG1, $ARG2, $link)
    {
        $file   = $ARG1."extensions/db_base_in.ael";
        $result = c_mysqli_call($link, 'ast_GetEmployAidClear', '');

        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';

        if (count($result) > 0)
        {
            shell_exec("rm -f $file");

            foreach ($result as $row)
            {
                file_put_contents($file,'abstract context BaseIncoming_'.$row['Aid'].' {'."\n", FILE_APPEND);
                file_put_contents($file,'   _[+0-9A-Za-z]. => {'."\n", FILE_APPEND);
                file_put_contents($file,'       MSet(Aid='.$row['Aid'], FILE_APPEND);
                if(isset($row['TariffLimit']) && strlen($row['TariffLimit'])>0)
                {
                    if((int)$row['TariffLimit'] < 5)
                        file_put_contents($file,',TariffLimit=5', FILE_APPEND);
                    else
                        file_put_contents($file,',TariffLimit='.$row['TariffLimit'], FILE_APPEND);
                }
                else
                    file_put_contents($file,',TariffLimit=5;', FILE_APPEND);
                if(isset($row['TariffDate']) && strlen($row['TariffDate'])>0)
                    file_put_contents($file,',TariffDate="'.$row['TariffDate'].'"', FILE_APPEND);
                else
                    file_put_contents($file,',TariffDate=null', FILE_APPEND);
                file_put_contents($file,');', FILE_APPEND);
                file_put_contents($file,'       &abstractBaseIn();'."\n", FILE_APPEND);
                file_put_contents($file,'       //First CallingCard'."\n", FILE_APPEND);
                file_put_contents($file,'       &postCallincard();'."\n", FILE_APPEND);//
                file_put_contents($file,'       goto route_in_'.$row['Aid'].',${EXTEN},1;'."\n", FILE_APPEND);
                file_put_contents($file,'   }'."\n", FILE_APPEND);
                file_put_contents($file,'}'."\n\n", FILE_APPEND);
            }
            echo 'base_in: created "'.$file .'"'."\n";

            /////////////////////////////////////////////// ----------------------------- incoming.ael
            $file       = $ARG1."extensions/db_incoming.ael";
            shell_exec("rm -f $file");

            foreach ($result as $row)
                file_put_contents($file,'context incoming_'.$row['Aid'].' { includes { BaseIncoming_'.$row['Aid'].';  } }'."\n", FILE_APPEND);

            echo 'db_incoming: created "'.$file .'"'."\n";
            if(file_exists($file))
                $out_data = file($file);
            else
                $out_data = '';
            return checkFile($ARG2."asterisk -rx 'ael reload'", $in_data, $out_data);
        }
        else
            return 'no changes';
    }

?>