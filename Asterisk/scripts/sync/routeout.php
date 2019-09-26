<?php

    function routeout($ARG1, $ARG2, $link)
    {
        $file  = $ARG1."extensions/db_route_out.ael";
        $file2  = $ARG1."extensions/db_company.ael";
        $file3  = $ARG1."extensions/db_scenario.ael";
        $context_prefix = 'route';
        $result = c_mysqli_call($link, 'ast_GetRouteOutgoingClear', 'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, "ASC", "priority", NULL, NULL');
        $result_Aid = c_mysqli_call($link, 'ast_GetEmployAidClear', '');
        foreach ($result_Aid as $key => $info)
        {
            $result_Aid[$info['Aid']] = $info;
            unset($result_Aid[$key]);
        }
        $result_Aid_coID = $result_Aid;
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';

        $struct = $contextGroup = $sips = [];
        foreach ($result as $info)
        {
            $struct[$info['Aid']][$info['roID']]['info'][] = $info;
            $struct[$info['Aid']][$info['roID']]['pattern'][] = $info['pattern'];
            $struct[$info['Aid']][$info['roID']]['Aid'] = $info['Aid'];
            $struct[$info['Aid']][$info['roID']]['roID'] = $info['roID'];
            $struct[$info['Aid']][$info['roID']]['roName'] = $info['roName'];
            $struct[$info['Aid']][$info['roID']]['prefix'] = $info['prefix'];
            $struct[$info['Aid']][$info['roID']]['prepend'] = $info['prepend'];
            $struct[$info['Aid']][$info['roID']]['destination'] = $info['destination'];
            $struct[$info['Aid']][$info['roID']]['destinationName'] = $info['destinationName'];
            $struct[$info['Aid']][$info['roID']]['destdata'] = $info['destdata'];
            $struct[$info['Aid']][$info['roID']]['callerID'] = $info['rcallerID'];
            $struct[$info['Aid']][$info['roID']]['icallerID'] = $info['icallerID'];
            $struct[$info['Aid']][$info['roID']]['coID'] = $info['coID'];
        }
        foreach ($result_Aid as $key => $info)
            if(isset($struct[$info['Aid']]))
                unset($result_Aid[$key]);
        shell_exec("rm -f $file");
        shell_exec("rm -f $file2");
        shell_exec("rm -f $file3");
        if (count($struct) > 0)
        {
            foreach ($struct as $Aid => $route)
            {
                unset($contextGroup);
                file_put_contents($file,'context '.$context_prefix.'_'.$Aid. ' {'."\n"        , FILE_APPEND);
                file_put_contents($file,'   _X. => {'."\n"        , FILE_APPEND);
                foreach ($route as $key => $data)
                {
                    if((isset($data['coID']) && strlen($data['coID'])>0))
                    {
                        file_put_contents($file,'           if("${coID}" != "null"){ goto db_coID_'.$data['Aid'].',${EXTEN},1; } '."\n"        , FILE_APPEND);
                        break;
                    }
                }

                file_put_contents($file,'           //Route changers'."\n"        , FILE_APPEND);
                foreach ($route as $key => $data)
                    if(!(isset($data['icallerID']) && strlen($data['icallerID'])>0) && ((strlen($data['coID']) == 0) || ((int)$data['coID'] == 0)))
                    {
                        $reg = makeRegExp($data['pattern']);
                        if(strlen($reg)>0)
                            file_put_contents($file,'           if( ${REGEX("'.$reg.'" ${EXTEN})} == 1)  goto '.$context_prefix.'_'.$data['roID'].'_'.$data['Aid'].'|${EXTEN}|1;'."\n"        , FILE_APPEND);
                    }

                $query = "SELECT sipName 
                            FROM ast_sippeers 
                            WHERE isActive = TRUE AND 
                                    Aid = ".$Aid." AND
                                    emID IN (SELECT emID FROM emEmploy WHERE isActive = TRUE AND Aid = ".$Aid.");";
                $result = mysqli_query($link, $query) or die("Query fail: " . mysqli_error($link));
                unset($sips);
                while ($row = mysqli_fetch_array($result)) {
                    $sips[] = $row['sipName'];
                    $sips[] = $row['sipName'].'_'.$Aid;
                }
                if (isset($sips) && count($sips))
                    file_put_contents($file,'           if( ${REGEX("^('.implode('|', $sips).')$" ${EXTEN})} == 1) goto db_sip_'.$Aid.',${EXTEN},1;'."\n"        , FILE_APPEND);
                file_put_contents($file,'           disposition=FAILED;'."\n"        , FILE_APPEND);
                file_put_contents($file,'           Hangup;'."\n"        , FILE_APPEND);
                file_put_contents($file,'   }'."\n"        , FILE_APPEND);

                foreach ($route as $data_route)
                {
                    foreach ($data_route['info'] as $data)
                    {
                        if((isset($data['icallerID']) && strlen($data['icallerID'])>0) && ((strlen($data['coID']) == 0) || ((int)$data['coID'] == 0)))
                        {
                            if(ctype_digit(trim($data['icallerID'])))
                                $pref = '_X./'.$data['icallerID'];
                            elseif(((strpos(trim($data['icallerID']), '.') === false) &&
                                (strpos(trim($data['icallerID']), '[') === false) &&
                                (strpos(trim($data['icallerID']), ']') === false) &&
                                (strpos(trim($data['icallerID']), '-') === false) &&
                                (strpos(trim($data['icallerID']), 'X') === false) &&
                                (strpos(trim($data['icallerID']), 'N') === false) &&
                                (strpos(trim($data['icallerID']), 'Z') === false)))
                                $pref = '_X./'.$data['icallerID'];
                            else
                                $pref = '_X./_'.$data['icallerID'];
                            $contextGroup[$pref][] = 'Set(reg_'.$data['roID'].'_'.$data['Aid'].'='.makeRegExp($data['pattern']).'); if( ${REGEX("${reg_'.$data['roID'].'_'.$data['Aid'].'}" ${EXTEN})} == 1)  goto '.$context_prefix.'_'.$data['roID'].'_'.$data['Aid'].'|${EXTEN}|1;';
                        }
                    }
                }
                if(isset($contextGroup) && count($contextGroup)>0)
                {
                    foreach ($contextGroup as $key => $way)
                    {
                        file_put_contents($file,'   '.$key.' => {'."\n"        , FILE_APPEND);
                        if(count($way)>0)
                        {
                            foreach ($way as $router)
                                file_put_contents($file,'       '.$router."\n"        , FILE_APPEND);
                        }
                        file_put_contents($file,'       goto db_sip_'.$Aid.',${EXTEN},1;'."\n"        , FILE_APPEND);
                        file_put_contents($file,'       Hangup;'."\n"        , FILE_APPEND);
                        file_put_contents($file,'   }'."\n\n"        , FILE_APPEND);
                    }
                }
                file_put_contents($file,'   i => { disposition=FAILED; Hangup; }'."\n"        , FILE_APPEND);
                file_put_contents($file,'   e => { disposition=FAILED; PlayBack(invalid); Hangup; }'."\n"        , FILE_APPEND);
                file_put_contents($file,'   h => &postCallincard();'."\n"        , FILE_APPEND);
                file_put_contents($file,'}'."\n\n"        , FILE_APPEND);

                foreach ($route as $key => $data_route)
                {
                    unset($contextGroup);
                    if((strlen($data_route['coID']) == 0) || ((int)$data_route['coID'] == 0))
                    {
                        file_put_contents($file,'// route "'.$data_route['roName'].'"   => destination "'.$data_route['destinationName'].'"'."\n"        , FILE_APPEND);
                        file_put_contents($file,'context '.$context_prefix.'_'.$data_route['roID'].'_'.$data_route['Aid'].' { '."\n"        , FILE_APPEND);

                        foreach ($data_route['info'] as $data)
                            $contextGroup[] = trim(str_replace('${optionsIn}', '${options}', str_replace('h => &postCallincard();', ' ', routeInfo($link, $Aid, 'routeout', $data['destination'], ['destdata' => $data['destdata'], 'prefix' => $data['prefix'], 'prepend' => $data['prepend'], 'callerID' => $data_route['callerID'], 'icallerID' => $data['icallerID']]))));
                        $contextGroup = array_unique($contextGroup);
                        if(count($contextGroup)>0 && isset($contextGroup[0]) && strlen($contextGroup[0])>0)
                        {
                            foreach ($contextGroup as $data)
                                file_put_contents($file, '    ' . $data . "\n", FILE_APPEND);
                        }
                        else
                        {
                            file_put_contents($file, '    _X. => { disposition=FAILED; Hangup; }' . "\n", FILE_APPEND);
                        }
                        file_put_contents($file,'    h => &postCallincard();'."\n"        , FILE_APPEND);
                        file_put_contents($file,'} '."\n\n"        , FILE_APPEND);
                    }
                }
            }
            if (count($result_Aid) > 0) {
                foreach ($result_Aid as $route) {
                    unset($contextGroup);
                    file_put_contents($file, 'context ' . $context_prefix . '_' . $route['Aid'] . ' {' . "\n", FILE_APPEND);
                    file_put_contents($file, '   _X. => {' . "\n", FILE_APPEND);
                    file_put_contents($file, '           if("${coID}" != "null"){ goto db_coID_' . $route['Aid'] . ',${EXTEN},1; } ' . "\n", FILE_APPEND);
                    file_put_contents($file, '           goto db_sip_' . $route['Aid'] . ',${EXTEN},1;' . "\n", FILE_APPEND);
                    file_put_contents($file, '           disposition=FAILED;' . "\n", FILE_APPEND);
                    file_put_contents($file, '           Hangup;' . "\n", FILE_APPEND);
                    file_put_contents($file, '   }' . "\n", FILE_APPEND);
                    file_put_contents($file, '   h => &postCallincard();' . "\n", FILE_APPEND);
                    file_put_contents($file, '   i => {' . "\n", FILE_APPEND);
                    file_put_contents($file, '           Progress;' . "\n", FILE_APPEND);
                    file_put_contents($file, '           agi(googletts.agi,"${CALLERID(name)}, неправильно набран номер",ru_RU);' . "\n", FILE_APPEND);
                    file_put_contents($file, '           Hangup;' . "\n", FILE_APPEND);
                    file_put_contents($file, '   }' . "\n", FILE_APPEND);
                    file_put_contents($file, '   e => PlayBack(invalid);' . "\n", FILE_APPEND);
                    file_put_contents($file, '}' . "\n\n", FILE_APPEND);
                }
            }
            echo 'routeoutgoing: created "'.$file .'"'."\n";
            if(file_exists($file))
                $out_data = file($file);
            else
                $out_data = '';
            //companies
            foreach ($struct as $Aid => $route)
            {

                $needUse = false;
                foreach ($route as $key => $data)
                {

                    if((isset($data['coID']) && strlen($data['coID'])>0) && (int)(trim($data['coID']))>0)
                        $needUse = true;
                }
                if($needUse == true)
                {
                    unset($result_Aid_coID[$Aid]);
                    unset($contextGroup);
                    file_put_contents($file2,'context db_coID_'.$Aid. ' {'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'   _X. => {'."\n"        , FILE_APPEND);

                    foreach ($route as $key => $data)
                    {
                        if(!(isset($data['icallerID']) && strlen($data['icallerID'])>0) && (isset($data['coID']) && (strlen($data['coID'])>0) && ((int)$data['coID']>0)))
                        {
                            file_put_contents($file2,'           if("${coID}" == "'.trim($data['coID']).'") {'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'              //Regular formilas'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'              Set(reg_'.$data['roID'].'_'.$data['Aid'].'='.makeRegExp($data['pattern']).');'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'              //Route changers'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'              if( ${REGEX("${reg_'.$data['roID'].'_'.$data['Aid'].'}" ${EXTEN})} == 1)  goto db_coID_'.$data['roID'].'_'.$data['Aid'].'|${EXTEN}|1;'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'           }'."\n"        , FILE_APPEND);
                        }
                    }

                    file_put_contents($file2,'           goto db_sip_'.$Aid.',${EXTEN},1;'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'           Hangup;'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'   }'."\n\n"        , FILE_APPEND);

                    foreach ($route as $data_route)
                    {
                        foreach ($data_route['info'] as $data)
                        {
                            if((isset($data['icallerID']) && strlen($data['icallerID'])>0) && (isset($data['coID']) && (strlen($data['coID'])>0) && ((int)$data['coID']>0)))
                            {
                                if(ctype_digit(trim($data['icallerID'])))
                                    $pref = '_X./'.$data['icallerID'];
                                elseif(((strpos(trim($data['icallerID']), '.') === false) &&
                                        (strpos(trim($data['icallerID']), '[') === false) &&
                                        (strpos(trim($data['icallerID']), ']') === false) &&
                                        (strpos(trim($data['icallerID']), '-') === false) &&
                                        (strpos(trim($data['icallerID']), 'X') === false) &&
                                        (strpos(trim($data['icallerID']), 'N') === false) &&
                                        (strpos(trim($data['icallerID']), 'Z') === false)))
                                    $pref = '_X./'.$data['icallerID'];
                                else
                                    $pref = '_X./_'.$data['icallerID'];
                                $contextGroup[$pref][] = 'Set(reg_'.$data['roID'].'_'.$data['Aid'].'='.makeRegExp($data['pattern']).'); if( ${REGEX("${reg_'.$data['roID'].'_'.$data['Aid'].'}" ${EXTEN})} == 1)  goto db_coID_'.$data['roID'].'_'.$data['Aid'].'|${EXTEN}|1;';
                            }
                        }
                    }
                    if(isset($contextGroup) && count($contextGroup)>0)
                    {
                        foreach ($contextGroup as $key => $way)
                        {
                            file_put_contents($file2,'   '.$key.' => {'."\n"        , FILE_APPEND);
                            if(count($way)>0)
                            {
                                foreach ($way as $router)
                                    file_put_contents($file2,'       '.$router."\n"        , FILE_APPEND);
                            }
                            file_put_contents($file2,'       goto db_sip_'.$Aid.',${EXTEN},1;'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'       Hangup;'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'   }'."\n\n"        , FILE_APPEND);
                        }
                    }
                    file_put_contents($file2,'   h => &postCallincard();'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'   i => {'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'           Progress;'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'           agi(googletts.agi,"${CALLERID(name)}, неправильно набран номер",ru_RU);'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'           Hangup;'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'   }'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'   e => PlayBack(invalid);'."\n"        , FILE_APPEND);
                    file_put_contents($file2,'}'."\n\n"        , FILE_APPEND);

                    foreach ($route as $key => $data_route)
                    {
                        $needUse = false;
                        foreach ($data_route['info'] as $data) {
                            if ((isset($data['coID']) && strlen($data['coID']) > 0) && (int)(trim($data['coID'])) > 0)
                                $needUse = true;
                        }
                        if($needUse)
                        {
                            unset($contextGroup);
                            file_put_contents($file2,'// route "'.$data_route['roName'].'"   => destination "'.$data_route['destinationName'].'"'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'context db_coID_'.$data_route['roID'].'_'.$data_route['Aid'].' { '."\n"        , FILE_APPEND);

                            foreach ($data_route['info'] as $data)
                                $contextGroup[] = trim(str_replace('${optionsIn}', '${options}', str_replace('h => &postCallincard();', ' ', routeInfo($link, $Aid, 'routeout', $data['destination'], ['destdata' => $data['destdata'], 'prefix' => $data['prefix'], 'prepend' => $data['prepend'], 'callerID' => $data_route['callerID'], 'icallerID' => $data['icallerID']]))));
                            $contextGroup = array_unique($contextGroup);
                            foreach ($contextGroup as $data)
                                file_put_contents($file2, '    ' . $data . "\n", FILE_APPEND);
                            file_put_contents($file2,'    h => &postCallincard();'."\n"        , FILE_APPEND);
                            file_put_contents($file2,'} '."\n\n"        , FILE_APPEND);
                        }
                    }
                }
            }
            $result = c_mysqli_call($link, 'ast_GetScenarioClear', 'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, NULL, NULL, NULL, 100000');

            //scenario
            $struct = $contextGroup = $sips = [];
            unset($result_Aid);
            foreach ($result as $info)
            {
                if(strlen(trim($info['roIDs']))>0)
                {
                    $struct[$info['Aid']][$info['id_scenario']]['info'] = $info;
                    $struct[$info['Aid']][$info['id_scenario']]['id_scenario'] = $info['id_scenario'];
                    $struct[$info['Aid']][$info['id_scenario']]['roIDs'] = $info['roIDs'];
                    $result_Aid[$info['Aid']][] = $info['id_scenario'];
                }
            }
            $worksID = 0;
            if (isset($result_Aid) && count($result_Aid) > 0) {
                foreach ($result_Aid as $Aid => $route) {
                    foreach ($route as $data)
                    {
                        unset($contextGroup);
                        if($worksID != $Aid)
                        {
                            file_put_contents($file3, 'context route_scenario_'.$data.'_' . $Aid. ' {' . "\n", FILE_APPEND);
                            file_put_contents($file3,'   _X. => {'."\n"        , FILE_APPEND);
                            file_put_contents($file3,'           //Route changers'."\n"        , FILE_APPEND);
                            $worksID = $Aid;
                        }
                        $routesScenario = explode(',', $struct[$Aid][$data]['roIDs']);
                        foreach ($routesScenario as $item)
                        {
                            $result = c_mysqli_call($link, 'ast_GetRouteOutgoingClear', 'NULL, '.$item.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, "ASC", "priority", NULL, NULL');
                            foreach ($result as $pattern)
                            {
                                $result['Aid'] = $pattern['Aid'];
                                $result['pattern'][] = $pattern['pattern'];
                            }
                            if(isset($result['pattern']))
                            {
                                $reg = makeRegExp($result['pattern']);
                                if(strlen($reg)>0)
                                    file_put_contents($file3,'           if( ${REGEX("'.$reg.'" ${EXTEN})} == 1)  goto '.$context_prefix.'_'.$item.'_'.$result['Aid'].'|${EXTEN}|1;'."\n"        , FILE_APPEND);
                            }
                        }
                        file_put_contents($file3,'           disposition=FAILED;'."\n"        , FILE_APPEND);
                        file_put_contents($file3,'           Hangup;'."\n"        , FILE_APPEND);
                        file_put_contents($file3,'   }'."\n"        , FILE_APPEND);
                        file_put_contents($file3,'   i => { disposition=FAILED; Hangup; }'."\n"        , FILE_APPEND);
                        file_put_contents($file3,'   e => { disposition=FAILED; PlayBack(invalid); Hangup; }'."\n"        , FILE_APPEND);
                        file_put_contents($file3,'   h => &postCallincard();'."\n"        , FILE_APPEND);
                        file_put_contents($file3,'}'."\n\n"        , FILE_APPEND);
                        $worksID = 0;
                    }
                }
            }

            echo 'scenario: created "'.$file3 .'"'."\n";

            return checkFile($ARG2."asterisk -rx 'ael reload'", $in_data, $out_data);
        }
        else
            return 'no changes';
    }

?>