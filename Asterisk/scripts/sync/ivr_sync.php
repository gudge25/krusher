<?php

    function ivr_sync ($ARG1, $ARG2, $link)
    {
        $file       = $ARG1."extensions/db_ivr.ael";

        $result = c_mysqli_call($link, 'ast_GetIVRConfigClear', 'NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, "ASC", NULL , 0, 10000');

        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';

        $struct = $group = [];
        foreach ($result as $info)
        {
            $struct[$info['Aid']]['info'][] = $info;
            $struct[$info['Aid']]['Aid'] = $info['Aid'];
        }
        shell_exec("rm -f $file");
        if(count($struct) > 0)
        {
            foreach ($struct as $config)
            {
                foreach ($config['info'] as $ivr)
                {
                    file_put_contents($file, "      //" . $ivr['ivr_name'] . "\n", FILE_APPEND);
                    file_put_contents($file,'context db_ivr_'.$ivr['id_ivr_config'].'_'. $config['Aid'].' { '."\n", FILE_APPEND);
                    if(isset($ivr['id_ivr_config']))
                    {
                        $ael = $engine = '';
                        unset($counterRetry);
                        $counterRetry = [];
                        $invalid_retries = $timeout_retries = 0;
                        if(isset($ivr['invalid_retries']) && (strlen(trim($ivr['invalid_retries']))>0))
                            $invalid_retries = trim($ivr['invalid_retries']);
                        if(isset($ivr['timeout_retries']) && (strlen(trim($ivr['timeout_retries']))>0))
                            $timeout_retries = trim($ivr['timeout_retries']);

                        $ttsBefore = $ttsAfter = $member = $data_check = $invalid = $timeout = $ttsengine = array();
                        if(isset($ivr['record_id']) && (strlen(trim($ivr['record_id']))>0))
                        {
                            unset($data_check);
                            $data_check = explode(',', $ivr['record_id']);
                            foreach ($data_check as $data)
                                $member[] = 'BackGround(${Record}'.call_Record_Name($config['Aid'], $data, $link).');';
                        }
                        if(isset($ivr['invalid_record_id']) && (strlen(trim($ivr['invalid_record_id']))>0))
                        {
                            unset($data_check);
                            $data_check = explode(',', $ivr['invalid_record_id']);
                            foreach ($data_check as $data)
                                $invalid[] = 'Playback(${Record}'.call_Record_Name($config['Aid'], $data, $link).');';
                        }
                        if(isset($ivr['timeout_record_id']) && (strlen(trim($ivr['timeout_record_id']))>0))
                        {
                            unset($data_check);
                            $data_check = explode(',', $ivr['timeout_record_id']);
                            foreach ($data_check as $data)
                                $timeout[] = 'BackGround(${Record}'.call_Record_Name($config['Aid'], $data, $link).');';
                        }
                        if(isset($ivr['ttsID']))
                            if (strlen($ivr['ttsID']) > 0 && $ivr['ttsID'] != 0) {
                                $ttsIDs = explode(',', $ivr['ttsID']);
                                foreach ($ttsIDs as $tid)
                                    $ttsengine[] = call_TTS_Data($config['Aid'], $tid, $link)[0];
                            }

                        unset($ttsBeforeList);
                        unset($ttsAfterList);
                        unset($ttfFieldsList);
                        unset($ttsData);
                        $ttsBeforeList = $ttsAfterList = $ttfFieldsList = [];
                        foreach ($ttsengine as $key => $ttsItem) {
                            $ttsBeforeList = explode(',', $ttsItem['recIDBefore']);
                            $ttsAfterList = explode(',', $ttsItem['recIDAfter']);
                            $ttfFieldsList = explode(',', $ttsItem['ttsFields']);
                            if (isset($ttsBeforeList) && count($ttsBeforeList) > 0) {
                                foreach ($ttsBeforeList as $bItem)
                                    if (strlen(trim($bItem)) > 0) {
                                        $rec = call_Record_Name($config['Aid'], $bItem, $link);
                                        if (strlen($rec) > 0)
                                            $ttsData[$key]['before'][] = ' BackGround(${Record}' . $rec . ');';
                                    }
                            } else
                                $ttsData[$key]['before'][] = '';
                            if (isset($ttfFieldsList) && count($ttfFieldsList) > 0) {
                                foreach ($ttfFieldsList as $fItem)
                                    if (strlen(trim($fItem)) > 0) {
                                        $rec = c_mysqli_call($link, 'ast_GetTtsFieldsClear', $config['Aid'] . ', ' . $fItem . ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL');
                                        if (isset($rec[0]['field']) && strlen($rec[0]['field']) > 0)
                                            $ttsData[$key]['field'][] = $rec[0]['field'];
                                    }
                            } else
                                $ttsData[$key]['field'][] = '';
                            if (isset($ttsAfterList) && count($ttsAfterList) > 0) {
                                foreach ($ttsAfterList as $aItem) {
                                    if (strlen(trim($aItem)) > 0) {
                                        $rec = call_Record_Name($config['Aid'], $aItem, $link);
                                        if (strlen($rec) > 0)
                                            $ttsData[$key]['after'][] = ' BackGround(${Record}' . $rec . ');';
                                    }
                                }
                            } else
                                $ttsData[$key]['after'][] = '';

                            if (isset($ttsItem['engID'])) {
                                switch ($ttsItem['engID']) {
                                    case '102403':
                                        $ttsData[$key]['engine'] = " &say_money();";
                                        break;
                                    case '102401':
                                        $ttsData[$key]['engine'] = " &google_tts(fields);";
                                        break;
                                }
                            }

                        }
                        if (isset($ttsData) && count($ttsData) > 0)
                            foreach ($ttsData as $ttsItem) {
                                $ttsData['result'][] = (isset($ttsItem['before']) ? implode(' ', $ttsItem['before']) : '') .
                                    (isset($ttsItem['field']) ? ' ' . str_replace('fields', implode('|', $ttsItem['field']), $ttsItem['engine']) : '') .
                                    (isset($ttsItem['engine']) ? ' ' . $ttsItem['engine'] : '') .
                                    (isset($ttsItem['after']) ? ' ' . implode(' ', $ttsItem['after']) : '');
                            }

                        $result_item = c_mysqli_call($link, 'ast_GetIVREntriesClear', "NULL, ".$ivr['id_ivr_config'] .", NULL, NULL, NULL, NULL, NULL, TRUE, 'ASC', NULL, NULL, NULL");

                        if(intval($invalid_retries) > 0)
                        {
                            $counterRetry['if']['i'] = 'if(${ci} > 0) { ci=${ci}-1; goto s,begin; }';
                            $counterRetry['var'][] = 'ci='.$invalid_retries.';';
                        }
                        if(intval($timeout_retries) > 0)
                        {
                            $counterRetry['if']['t'] = 'if(${ct} > 0) { ct=${ct}-1; goto s,begin; }';
                            $counterRetry['var'][] = 'ct='.$timeout_retries.';';
                        }

                        if(isset($ivr['timeout']) && (strlen(trim($ivr['timeout']))>0) && (trim($ivr['timeout'])!='0'))
                        {
                            $str = "   s => { Set(target=); " . ((isset($counterRetry['var']) && count($counterRetry['var']) > 0) ? implode(' ', $counterRetry['var']) : "") . "  begin: " . implode(' ', $member) . (isset($ttsData['result']) ? " " . implode(' ', $ttsData['result']) : '') . " WaitExten(" . $ivr['timeout'] . "); }";
                            if(strpos($str, 'BackGround')>0)
                                $str = str_replace('begin', 'disposition=UP; &postCallincard(); begin', $str);
                            file_put_contents($file, $str."\n", FILE_APPEND);
                        }
                        else
                        {
                            $str = "   s => { Set(target=); " . ((isset($counterRetry['var']) && count($counterRetry['var']) > 0) ? implode(' ', $counterRetry['var']) : "") . "  begin: " . implode(' ', $member) . (isset($ttsData['result']) ? " " . implode(' ', $ttsData['result']) : '') . " goto t,1;  Hangup; }";
                            if(strpos($str, 'BackGround')>0)
                                $str = str_replace('begin', 'disposition=UP; &postCallincard(); begin', $str);
                            file_put_contents($file, $str."\n", FILE_APPEND);
                        }

                        if(!empty($invalid))
                        {
                            $ael = routeInfo($link, $config['Aid'], 'invalid_ivr', $ivr['invalid_destination'],  ['destdata' => $ivr['invalid_destdata'], 'destdata2' => $ivr['invalid_destdata2']]);
                            file_put_contents($file, '   i => { &target(${EXTEN}); ' . implode(' ', $invalid) . ' ' . $ael . ' ' . ((isset($counterRetry['if']['i']) && count($counterRetry['if']['i']) > 0) ? $counterRetry['if']['i'] : '') . ' Hangup; }' . "\n", FILE_APPEND);
                        }
                        else
                        {
                            $ael = routeInfo($link, $config['Aid'], 'invalid_ivr', $ivr['invalid_destination'],  ['destdata' => $ivr['invalid_destdata'], 'destdata2' => $ivr['invalid_destdata2']]);
                            file_put_contents($file, '   i => { &target(${EXTEN}); ' . $ael . ' ' . ((isset($counterRetry['if']['i']) && count($counterRetry['if']['i']) > 0) ? $counterRetry['if']['i'] : '') . ' Hangup; }' . "\n", FILE_APPEND);
                        }

                        if(!empty($timeout))
                        {
                            $ael = routeInfo($link, $config['Aid'], 'invalid_ivr', $ivr['timeout_destination'],  ['destdata' => $ivr['timeout_destdata'], 'destdata2' => $ivr['timeout_destdata2']]);
                            file_put_contents($file, '   t => { &target(${EXTEN}); ' . implode(' ', $timeout) . ' ' . str_replace('Playback', 'BackGround', $ael) . ' ' . ((isset($counterRetry['if']['t']) && count($counterRetry['if']['t']) > 0) ? $counterRetry['if']['t'] : '') . ' Hangup; }' . "\n", FILE_APPEND);
                        }
                        else
                        {
                            $ael = routeInfo($link, $config['Aid'], 'invalid_ivr', $ivr['timeout_destination'],  ['destdata' => $ivr['timeout_destdata'], 'destdata2' => $ivr['timeout_destdata2']]);
                            file_put_contents($file, '   t => { &target(${EXTEN}); ' . $ael . ' ' . ((isset($counterRetry['if']['t']) && count($counterRetry['if']['t']) > 0) ? $counterRetry['if']['t'] : '') . ' Hangup; }' . "\n", FILE_APPEND);
                        }

                        if ($result_item) {
                            unset($group);
                            foreach ($result_item as $item) {
                                $ael = routeInfo($link, $config['Aid'], 'ivr', $item['destination'], ['destdata' => $item['destdata'], 'destdata2' => $item['destdata2']]);
                                //TARGET
                                $target = "&target(\${EXTEN});";
                                if(ctype_digit(trim($item['extension'])))
                                    $group[] = $item['extension'] . ' => { ' . $target . $ael . ' }';
                                elseif(((strpos('~'.trim($item['extension']), '.') > 0) ||
                                        (strpos('~'.trim($item['extension']), '[') > 0) ||
                                        (strpos('~'.trim($item['extension']), ']') > 0) ||
                                        (strpos('~'.trim($item['extension']), '-') > 0) ||
                                        (strpos('~'.trim($item['extension']), 'X') > 0) ||
                                        (strpos('~'.trim($item['extension']), 'N') > 0) ||
                                        (strpos('~'.trim($item['extension']), 'Z') > 0)))
                                    $group[] = '_'.$item['extension'] . ' => { ' . $target . $ael . ' }';
                                else
                                    $group[] = $item['extension'] . ' => { ' . $target . $ael . ' }';
                            }
                            $group = array_unique($group);

                            foreach ($group as $item)
                                file_put_contents($file, "      " . $item . "\n", FILE_APPEND);
                        }
                    }
                    else
                        file_put_contents($file,"   s => { BackGround(); goto t,1; Hangup; }\n", FILE_APPEND);

                    file_put_contents($file,'   h => { if("${IsOut}" = "false" ) &postCallincard(); } '."\n", FILE_APPEND);
                    file_put_contents($file,"}"." \n\n", FILE_APPEND);
                }
            }

            echo 'ivr_sync: created "'.$file .'"'."\n";
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