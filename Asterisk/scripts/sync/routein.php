<?php

    function routein($ARG1, $ARG2, $link)
    {
        $file = $ARG1 . "extensions/db_route_in.ael";
        $context_prefix = 'route_in';
        $result = c_mysqli_call($link, 'ast_GetRouteIncomingClear', 'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, NULL, NULL, 0, 10000');

        $out_data = $in_data = $list = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';
        $struct = array();
        foreach ($result as $info)
            $struct[$info['Aid']][$info['rtID']] = $info;
        shell_exec("rm -f $file");
        if (count($struct) > 0)
        {
            foreach ($struct as $Aid => $route)
            {
                file_put_contents($file,'context '.$context_prefix.'_'.$Aid. ' {'."\n"        , FILE_APPEND);
                foreach ($route as $key => $data)
                {
                    unset($list);
                    $list[] = $data['DID'];
                    if(strlen( $data['callerID'])>0)
                        $list[] = $data['callerID'];

                    $ael = routeInfo($link, $Aid, 'invalid_ivr', $data['destination'], ['destdata' => $data['destdata'], 'destdata2' => $data['destdata2']]);
                    if(strpos($ael, 'Hangup')>0)
                        file_put_contents($file, '       ' . implode('/', $list) . ' => { ' . ((isset($data['stick_destination']) && strlen($data['stick_destination']) > 0) ? ('&sticking(' . $data['stick_destination'] . ');') : '') /*.  . '  MSet(destination=' . $data['destination']  . (isset($data['destdata']) ? (',destdata=' . $data['destdata']) : '') . (isset($data['destdata2']) ? (',destdata2=' . $data['destdata2']) : '') . ',EXT=${EXTEN}); '*/ . $ael . "}\n", FILE_APPEND);
                    else
                        file_put_contents($file, '       ' . implode('/', $list) . ' => { ' . ((isset($data['stick_destination']) && strlen($data['stick_destination']) > 0) ? ('&sticking(' . $data['stick_destination'] . ');') : '') /*.  . '  MSet(destination=' . $data['destination']  . (isset($data['destdata']) ? (',destdata=' . $data['destdata']) : '') . (isset($data['destdata2']) ? (',destdata2=' . $data['destdata2']) : '') . ',EXT=${EXTEN}); ' */. $ael . " Hangup; }\n", FILE_APPEND);
                }
                file_put_contents($file,'       h => &postCallincard();'."\n"        , FILE_APPEND);
                file_put_contents($file,'} '."\n\n"        , FILE_APPEND);
            }

            echo 'routein: created "'.$file .'"'."\n";
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