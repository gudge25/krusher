<?php

    function call_Queue_Name($Aid, $ARG1, $link)
    {
        $result = [];
        $result3 = c_mysqli_call($link, 'ast_GetQueueClear',  $Aid.', '.$ARG1.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, "DESC", NULL, 0, 100');
        if($result3)
        {
            foreach ($result3 as $data)
            {
                $result = $data;
                break;
            }
        }
        return $result;
    }

    function call_Trunk_Name($Aid, $ARG1, $link)
    {
        $result3 = c_mysqli_call($link, 'ast_GetTrunkClear',$Aid.', '.$ARG1.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, NULL, NULL, 0, 1000');
        if($result3)
            return $result3[0];
        else
            return [];
    }

    function call_Record_Name($Aid, $ARG1, $link)
    {
        $result_ = '';
        $result3 = c_mysqli_call($link, 'ast_GetRecordClear', $Aid.', '.$ARG1.', NULL, NULL, TRUE, "DESC", NULL, 0, 1');
        if($result3)
        {
            foreach ($result3 as $data)
            {
                $result_ = pathinfo($data['record_source'], PATHINFO_FILENAME);
                break;
            }
        }
        return $result_;
    }

    function call_Pool_Name($Aid, $ARG1, $link)
    {
        $result = [];
        $result3 = c_mysqli_call($link, 'ast_GetPoolListClear', $Aid.', NULL, '. $ARG1.', NULL, NULL, TRUE, NULL, NULL, NULL, NULL');
        if($result3)
        {
            foreach ($result3 as $data)
                $result[] = $data;
        }
        return $result;
    }

    function call_TTS_Data($Aid, $ARG1, $link)
    {
        //$result_ = array();
        $result3 = c_mysqli_call($link, 'ast_GetTtsClear', $Aid . ', "' . $ARG1 . '", NULL, NULL, TRUE, "DESC", NULL, 0, NULL');
        /*if($result3)
        {
            foreach ($result3 as $data)
            {
                $result_[] = $data['engID'];
                $result_[] = $data['recIDBefore'];
                $result_[] = $data['recIDAfter'];
                $result_[] = $data['ttsFields'];
            }
        }*/
        return $result3;
    }

    function c_mysqli_call(mysqli $dbLink, $procName, $params="")
    {
        if(!$dbLink) {
            throw new Exception("The MySQLi connection is invalid.");
        }
        else
        {
            $sql = "CALL {$procName}({$params});";
            echo $sql."\n";
            $sqlSuccess = $dbLink->multi_query($sql);

            if($sqlSuccess)
            {
                if($dbLink->more_results())
                {
                    $result = $dbLink->use_result();
                    $output = array();

                    while($row = $result->fetch_assoc())
                        $output[] = $row;

                    $result->free();

                    while($dbLink->more_results() && $dbLink->next_result())
                    {
                        $extraResult = $dbLink->use_result();
                        if($extraResult instanceof mysqli_result)
                            $extraResult->free();
                    }

                    return $output;
                }
                else
                    return false;
            }
            else
                throw new Exception("The call failed: " . $dbLink->error);
        }
    }

    function routeInfo($link, $Aid, $type, $destination, $options)
    {
        if(isset($destination))
        {
            $ael = '';
            $defaultExten = '_X.';
            $callerID = '';
            if(isset($options['icallerID']) && strlen(trim($options['icallerID']))>0)
            {
                if(ctype_digit(trim($options['icallerID'])))
                    $defaultExten .= '/'.$options['icallerID'];
                else
                    $defaultExten .= '/_'.$options['icallerID'];
            }

            if(isset($options['callerID']) && strlen(trim($options['callerID']))>0)
                $callerID = ' Set(CALLERID(num)='.$options['callerID'].'); ';
            switch($destination)
            {
                //IF Destination empty -> Hangup
                case '':
                    $ael = ' Hangup; ';
                    break;
                //Queue
                case 101401:
                    if(isset($options['destdata']))
                    {
                        $check = intval($options['destdata']);
                        if($check > 0)
                            $queue = call_Queue_Name($Aid, $options['destdata'], $link);
                        else
                        {
                            $queue['queID'] = '';
                            $queue['max_wait_time'] = '';
                            $queue['fail_destination'] = '';
                            $queue['fail_destdata'] = '';
                            $queue['fail_destdata2'] = '';
                        }
                        $dest_remember = '';
                        $queueueue = [];
                        if(isset($queue['max_wait_time']) && strlen(trim($queue['max_wait_time']))>0)
                            $queueueue[] = /*'MSet(destination=' . $destination  . (isset($data['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',EXT=${EXTEN}); 15 03 2019*/' Queue('.$options['destdata'].',${optionsIn},,,'.$queue['max_wait_time'].',,,Q); ';
                        else
                            $queueueue[] = /*'MSet(destination=' . $destination  . (isset($data['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',EXT=${EXTEN}); 15 03 2019*/' Queue('.$options['destdata'].',${optionsIn},,,,,,Q); ';
                        while (isset($queue['fail_destdata']) && $queue['fail_destdata'] != $dest_remember)
                        {
                            if($queue['fail_destination'] == 101401)
                            {
                                $queue2 = call_Queue_Name($Aid, $queue['fail_destdata'], $link);
                                $queueueue[] = 'Queue('.$queue['fail_destdata'].',${optionsIn},,,'.$queue2['max_wait_time'].',,,Q); ';
                                $dest_remember = trim($queue['fail_destdata']);
                            }
                            else
                            {
                                $queueueue[] = routeInfo2($link, $Aid, ($type == 'invalid_ivr' ? 'invalid_ivr' : ($queue['fail_destination'] == 101407 ? 'invalid_ivr' : ($queue['fail_destination'] == 101405 ? 'ivr' : 'queue'))), $queue['fail_destination'], ['destdata' => $queue['fail_destdata'], 'destdata2' => $queue['fail_destdata2']]);
                                $dest_remember = trim($queue['fail_destdata']);
                            }
                            if(strlen(trim($queue['fail_destdata']))>0)
                                $queue = call_Queue_Name($Aid, $queue['fail_destdata'], $link);
                        }
                        if($type == 'invalid_ivr')
                            $ael    = 'Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.trim(str_replace('h => &postCallincard();', '', implode(' ', $queueueue))).' ';
                        elseif($type != 'ivr')
                        {
                            //$ael    = $defaultExten.' => { Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.implode(' ', $queueueue).' Hangup; }'."\n";
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.implode(' ', $queueueue).' Hangup; }'."\n";
                            $ael    .= '    h => &postCallincard(); ';
                        }
                        else
                            $ael    = 'Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.implode(' ', $queueueue).' Hangup; ';
                    }
                    break;
                //EXTEN
                case '101402':
                    if(isset($options['destdata']) && strlen($options['destdata'])>0)
                    {
                        $sip = c_mysqli_call($link, 'em_GetEmployClear', 'NULL, '.$options['destdata'].', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL');

                        /*if(isset($sip[0]['sipName']) && preg_match("/^[a-zA-Z0-9._-]+$/i", $sip[0]['sipName']))
                        {
                            if($type == 'invalid_ivr')
                                $ael = ' ' . $callerID . ' Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); ';
                            elseif($type != 'ivr')
                            {
                                $ael = $defaultExten . ' => { MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').');' . $callerID . ' Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); Hangup; }' . "\n";
                                $ael    .= '    h => &postCallincard(); ';
                            }
                            else
                                $ael = ' ' . $callerID . ' Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); Hangup; ';
                        }*/
                        if($type == 'invalid_ivr')
                            $ael = $callerID . 'MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',sip='.$sip[0]['sipName'] . '_' . $sip[0]['Aid']. ',EXT=${EXTEN}); Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); ';
                        elseif($type != 'ivr')
                        {
                            $ael = $defaultExten . ' => { ' . $callerID . 'MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',sip='.$sip[0]['sipName'] . '_' . $sip[0]['Aid'].',EXT=${EXTEN}); Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); Hangup; }' . "\n";
                            $ael    .= '    h => &postCallincard(); ';
                        }
                        else
                            $ael = $callerID . 'MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',sip='.$sip[0]['sipName'] . '_' . $sip[0]['Aid'].',EXT=${EXTEN}); Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); Hangup; ';
                    }
                    break;
                //Trunk
                case '101403':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        $trunk  = call_Trunk_Name($Aid, $options['destdata'], $link);
                        if(isset($trunk['trName']) && strlen(trim($trunk['trName']))>0)
                        {
                            if(!isset($options['prefix']))
                                $options['prefix'] = '';
                            else
                                $options['prefix'] = ':'.$options['prefix'];
                            if(!isset($options['prepend']))
                                $options['prepend'] = '';

                            if((isset($options['coID']) && strlen(trim($options['coID']))>0))
                                unset($trunk['coID']);
                            if($type == 'invalid_ivr')
                            {
                                if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . trim($options['destdata2']) . ',${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS}; ' . "\n";
                                else
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . ',${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS}; ' . "\n";
                            }
                            elseif($type != 'ivr')
                            {
                                if($type == 'routeout')
                                    $ael = $defaultExten . ' => { MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . $options['prepend'] . '${EXTEN' . $options['prefix'] . '},${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS}; Hangup; }' . "\n";
                                else
                                {
                                    if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                                        $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . trim($options['destdata2']) . ',${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS};  Hangup; ' . "\n";
                                    else
                                        $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . ',${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS}; Hangup; }' . "\n";
                                }
                                $ael    .= '            h => &postCallincard(); ';
                            }
                            else
                            {
                                if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . trim($options['destdata2']) . ',${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS}; Hangup; ' . "\n";
                                else
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' if("${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNKNOWN" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "INVALID" && "${DEVICE_STATE(SIP/' . $trunk['trName'] . '_' . $Aid . ')}" != "UNAVAILABLE"){ Dial(SIP/' . $trunk['trName'] . '_' . $Aid . ',${dialtime},${optionsIn}); if(${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',curcalls)} >= ${SIPPEER(' . $trunk['trName'] . '_' . $Aid . ',limit)}) { disposition=LIMIT; } } else disposition=${DIALSTATUS}; Hangup; ' . "\n";
                            }
                        }
                        else
                            $ael = '';
                    }
                    else
                        $ael = '';
                    break;
                //Terminate
                case '101404':
                    if($type == 'invalid_ivr')
                        $ael = 'disposition=FAILED; Hangup; ';
                    elseif($type != 'ivr')
                    {
                        $ael  = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); Hangup; }'."\n";
                        $ael .= '            h => &postCallincard(); ';
                    }
                    else
                        $ael    = ' Hangup; ';
                    break;
                //IVR
                case '101405':
                    if($type == 'invalid_ivr')
                        $ael  = '  MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .');  goto db_ivr_'.$options['destdata'].'_'.$Aid.',s,begin; ';
                    elseif($type != 'ivr')
                    {
                        $ael  = '   '.$defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_ivr_'.$options['destdata'].'_'.$Aid.',s,begin; Hangup;  }'."\n";
                        $ael .= '   h => &postCallincard(); ';
                    }
                    else
                        $ael  = '   MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_ivr_'.$options['destdata'].'_'.$Aid.',s,begin; Hangup;  ';

                    break;
                //Scenario
                case '101406':
                    $ael    = "";
                    break;
                //Record
                case '101407':
                    if(isset($options['destdata']) && strlen(trim($options['destdata']))>0)
                    {
                        $record = call_Record_Name($Aid, $options['destdata'], $link);

                        if($type == 'invalid_ivr')
                            $ael    = 'MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); Playback(${Record}'.$record.'); ';
                        elseif($type != 'ivr')
                        {
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); Playback(${Record}'.$record.'); Hangup;  }'."\n";
                            $ael    .= '        h => &postCallincard(); ';
                        }
                        else
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); Playback(${Record}'.$record.'); Hangup;  ';
                    }
                    else
                        $ael    = ' Hangup;  ';
                    break;
                //Custom destination
                case '101408':
                    if(isset($options['destdata']))
                    {
                        $cd = c_mysqli_call($link, 'ast_GetCustomDestinationClear', $Aid.', '.$options['destdata'].', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, "ASC", NULL, 0, NULL');
                        if(!isset($cd[0]['exten']))
                            $cd[0]['exten'] = '${EXTEN}';
                        if(!isset($cd[0]['priority']))
                            $cd[0]['priority'] = '1';

                        if($type == 'invalid_ivr')
                        {
                            if(isset($cd[0]['context']) && strlen($cd[0]['context'])>0)
                                $ael    = 'MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto '.$cd[0]['context'].'|'.$cd[0]['exten'].'|'.$cd[0]['priority'].'; ';
                            else
                                $ael = '';
                        }
                        elseif($type != 'ivr')
                        {
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto '.$cd[0]['context'].'|'.$cd[0]['exten'].'|'.$cd[0]['priority'].'; Hangup; } '."\n";
                            $ael    .= '        h => &postCallincard(); ';
                        }
                        else
                            $ael    = 'MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto '.$cd[0]['context'].'|'.$cd[0]['exten'].'|'.$cd[0]['priority'].'; Hangup;  ';
                    }
                    break;
                //Trunk pool
                case '101409':
                    $trunks = call_Pool_Name($Aid, $options['destdata'], $link);
                    $trunker = [];
                    if(count($trunks)>0)
                    {
                        if(!isset($options['prefix']))
                            $options['prefix'] = '';
                        else
                            $options['prefix'] = ':'.$options['prefix'];
                        if(!isset($options['prepend']))
                            $options['prepend'] = '';
                        foreach ($trunks as $key => $value)
                        {
                            $trunks[$key]['trName'] = $value['trName'] .'_'.$Aid;
                            if((isset($options['coID']) && strlen(trim($options['coID']))>0))
                                unset($trunks[$key]['coID']);
                            $trunker[] = $value['trName'] .'_'.$Aid;
                        }

                        if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                            $number = $options['destdata2'];
                        else
                            $number = $options['prepend'].'${EXTEN'.$options['prefix'].'}';

                        if($type == 'invalid_ivr')
                        {
                            $ael .= '             &GetFreeDev('.implode('|', $trunker).',random); if("${free}" != "") { '."\n".'             Set(channel=${CUT(free,_,1)});'."\n";
                            foreach ($trunks as $data)
                            {
                                if(isset($data['coID']) && strlen(trim($data['coID']))>0)
                                    $ael .= '             if("${free}" = "'.$data['trName'].'") Set(coID='.trim($data['coID']).');'."\n";
                            }
                            $ael .= '             '.((isset($callerID) && strlen(trim($callerID))>0) ? ($callerID."\n") : '' ).'             Dial(SIP/${free}/'.$number.'); }'."\n";

                        }
                        elseif($type != 'ivr')
                        {
                            $ael = $defaultExten.' => { destination='.$destination.'; '. (isset($options['destdata']) ? ('destdata='.$options['destdata'].'; ') : '') . (isset($options['destdata2']) ? ('destdata2='.$options['destdata2'].'; ') : '') ."\n";
                            $ael .= '             &GetFreeDev('.implode('|', $trunker).',random); if("${free}" != "") { '."\n".'             Set(channel=${CUT(free,_,1)});'."\n";
                            foreach ($trunks as $data)
                            {
                                if(isset($data['coID']) && strlen(trim($data['coID']))>0)
                                    $ael .= '             if("${free}" = "'.$data['trName'].'") Set(coID='.trim($data['coID']).');'."\n";
                            }
                            $ael .= '             '.((isset($callerID) && strlen(trim($callerID))>0) ? ($callerID."\n") : '' ).'    Dial(SIP/${free}/'.$number.'); }'."\n";
                            $ael .= '           Hangup; '."\n".'    }'."\n";
                            $ael .= '           h => &postCallincard(); ';
                        }
                        else
                        {
                            $ael = "\n";
                            $ael .= '             &GetFreeDev('.implode('|', $trunker).',random); if("${free}" != "") { '."\n".'             Set(channel=${CUT(free,_,1)});'."\n";
                            foreach ($trunks as $data)
                            {
                                if(isset($data['coID']) && strlen(trim($data['coID']))>0)
                                    $ael .= '             if("${free}" = "'.$data['trName'].'") Set(coID='.trim($data['coID']).');'."\n";
                            }
                            $ael .= '             '.((isset($callerID) && strlen(trim($callerID))>0) ? ($callerID."\n") : '' ).'             Dial(SIP/${free}/'.$number.'); }'."\n";
                            $ael .= '           Hangup; '."\n";
                        }
                    }
                    break;
                //Time Group
                case '101410':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        if($type == 'invalid_ivr')
                            $ael    = 'MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_time_'.$Aid.'_'.$options['destdata'].',${EXTEN},1;';
                        elseif($type != 'ivr')
                            $ael    = $defaultExten.' => { MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_time_'.$Aid.'_'.$options['destdata'].'|${EXTEN}|1; Hangup; } '."\n";
                        else
                            $ael    = 'MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_time_'.$Aid.'_'.$options['destdata'].',${EXTEN},1; Hangup; ';
                    }
                    else
                        $ael = '';
                    break;
                //Callback
                case '101411':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        if($type == 'invalid_ivr')
                            $ael    = 'MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_callback_'.$Aid.'_'.$options['destdata'].',s,1;';
                        elseif($type != 'ivr')
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_callback_'.$Aid.'_'.$options['destdata'].'|s|1; Hangup; } '."\n";
                        else
                            $ael    = 'MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_callback_'.$Aid.'_'.$options['destdata'].',s,1; Hangup; ';
                    }
                    else
                        $ael = '';
                    break;
                //Conference
                case '101412':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        if($type == 'invalid_ivr')
                            $ael    = 'MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_conference_'.$Aid.','.$options['destdata'].',1;';
                        elseif($type != 'ivr')
                            $ael    = $defaultExten.' => { MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_conference_'.$Aid.','.$options['destdata'].',1; Hangup; } '."\n";
                        else
                            $ael    = 'MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_conference_'.$Aid.','.$options['destdata'].',1; Hangup; ';
                    }
                    else
                        $ael = '';
                    break;
            }
            return $ael;
        }
    }

    function routeInfo2($link, $Aid, $type, $destination, $options)
    {
        if(isset($destination))
        {
            $ael = '';
            $defaultExten = '_X.';
            $callerID = '';
            if(isset($options['icallerID']) && strlen(trim($options['icallerID']))>0)
                if(isset($options['icallerID']) && strlen(trim($options['icallerID']))>0)
                {
                    if(ctype_digit(trim($options['icallerID'])))
                        $defaultExten .= '/'.$options['icallerID'];
                    else
                        $defaultExten .= '/_'.$options['icallerID'];
                }
            if(isset($options['callerID']) && strlen(trim($options['callerID']))>0)
                $callerID = ' Set(CALLERID(num)='.$options['callerID'].'); ';
            switch($destination)
            {
                //IF Destination empty -> Hangup
                case '':
                    $ael = ' Hangup; ';
                    break;
                //Queue
                case 101401:
                    if(isset($options['destdata']))
                    {
                        $check = intval($options['destdata']);
                        if($check > 0)
                            $queue = call_Queue_Name($Aid, $options['destdata'], $link);
                        else
                        {
                            $queue['queID'] = '';
                            $queue['max_wait_time'] = '';
                            $queue['fail_destination'] = '';
                            $queue['fail_destdata'] = '';
                            $queue['fail_destdata2'] = '';
                        }
                        $dest_remember = '';
                        $queueueue = [];
                        if(isset($queue['max_wait_time']) && strlen(trim($queue['max_wait_time']))>0)
                            $queueueue[] = /*'MSet(destination=' . $destination  . (isset($data['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',EXT=${EXTEN});*/' Queue('.$options['destdata'].',${optionsIn},,,'.$queue['max_wait_time'].',,,Q); ';
                        else
                            $queueueue[] = /*'MSet(destination=' . $destination  . (isset($data['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',EXT=${EXTEN});*/' Queue('.$options['destdata'].',${optionsIn},,,,,,Q); ';

                        while (isset($queue['fail_destdata']) && $queue['fail_destdata'] != $dest_remember)
                        {
                            if((strlen(trim($queue['fail_destination']))>0) && (strlen(trim($dest_remember)) == 0))
                                $dest_remember = trim($queue['fail_destdata']);
                            if($destination == 101401)
                            {
                                $queue2 = call_Queue_Name($Aid, $queue['fail_destdata'], $link);
                                $queueueue[] = 'Queue('.$queue['fail_destdata'].',${optionsIn},,,'.$queue2['max_wait_time'].',,,Q); ';
                            }
                            else
                                $queueueue[] = routeInfo($link, $Aid, 'queue', $queue['fail_destination'],  ['destdata' => $queue['fail_destdata'], 'destdata2' => $queue['fail_destdata2']]);
                            if(strlen(trim($queue['fail_destdata']))>0)
                                $queue = call_Queue_Name($Aid, $options['fail_destdata'], $link);
                        }

                        if($type == 'invalid_ivr')
                            $ael    = ' Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.implode(' ', $queueueue).' ';
                        elseif($type != 'ivr')
                        {
                            $ael    = $defaultExten.' => { Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.implode(' ', $queueueue).' Hangup; }'."\n";
                            $ael    .= '    h => &postCallincard(); ';
                        }
                        else
                            $ael    = ' Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .',GLOBAL(isQueue${ccName})=true,EXT=${EXTEN}); '.implode(' ', $queueueue).' Hangup; ';

                    /*    if($type == 'invalid_ivr')
                            $ael    = ' Answer; Set(GLOBAL(isQueue${ccName})=true); '.implode(' ', $queueueue).' ';
                        elseif($type != 'ivr')
                        {
                            $ael    = $defaultExten.' => { Answer; MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .', GLOBAL(isQueue${ccName})=true); '.implode(' ', $queueueue).' Hangup; }'."\n";
                            $ael    .= '    h => &postCallincard(); ';
                        }
                        else
                            $ael    = ' Answer; Set(GLOBAL(isQueue${ccName})=true); '.implode(' ', $queueueue).' Hangup; ';*/
                    }
                    break;
                //EXTEN
                case '101402':
                    if(isset($options['destdata']) && strlen($options['destdata'])>0)
                    {
                        $sip = c_mysqli_call($link, 'em_GetEmployClear', 'NULL, '.$options['destdata'].', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL');

                        if(isset($sip[0]['sipName']) && preg_match("/^[a-zA-Z0-9._-]+$/i", $sip[0]['sipName']))
                        {
                            if($type == 'invalid_ivr')
                                $ael = $callerID . ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',sip='.$sip[0]['sipName'] . '_' . $sip[0]['Aid'].'); Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); ';
                            elseif($type != 'ivr')
                            {
                                $ael = $defaultExten . ' => { '.$callerID . 'MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',sip='.$sip[0]['sipName'] . '_' . $sip[0]['Aid'].'); ' . 'Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); Hangup; }' . "\n";
                                $ael    .= '    h => &postCallincard(); ';
                            }
                            else
                                $ael = ' ' . $callerID . ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',sip='.$sip[0]['sipName'] . '_' . $sip[0]['Aid'].'); Dial(SIP/' . $sip[0]['sipName'] . '_' . $sip[0]['Aid'] . ',${dialtime},${optionsIn}); Hangup; ';
                        }
                    }
                    break;
                //Trunk
                case '101403':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        $trunk  = call_Trunk_Name($Aid, $options['destdata'], $link);
                        if(isset($trunk['trName']) && strlen(trim($trunk['trName']))>0)
                        {
                            if(!isset($options['prefix']))
                                $options['prefix'] = '';
                            else
                                $options['prefix'] = ':'.$options['prefix'];
                            if(!isset($options['prepend']))
                                $options['prepend'] = '';
                            if((isset($options['coID']) && strlen(trim($options['coID']))>0))
                                unset($trunk['coID']);
                            if($type == 'invalid_ivr')
                            {
                                if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . trim($options['destdata2']) . ',${dialtime},${optionsIn}); ' . "\n";
                                else
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . ',${dialtime},${optionsIn}); ' . "\n";
                            }
                            elseif($type != 'ivr')
                            {
                                if($type == 'routeout')
                                    $ael = $defaultExten . ' => { MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '') . ',channel=' . $trunk . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . $options['prepend'] . '${EXTEN' . $options['prefix'] . '},${dialtime},${optionsIn}); Hangup; }' . "\n";
                                else
                                {
                                    if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                                        $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName']. ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . trim($options['destdata2']) . ',${dialtime},${optionsIn});  Hangup; ' . "\n";
                                    else
                                        $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName']. ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . ',${dialtime},${optionsIn}); Hangup; }' . "\n";
                                }
                                $ael    .= '                h => &postCallincard(); ';
                            }
                            else
                            {
                                if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . '/' . trim($options['destdata2']) . ',${dialtime},${optionsIn}); Hangup; ' . "\n";
                                else
                                    $ael = ' MSet(destination=' . $destination . (isset($options['destdata']) ? (',destdata=' . $options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2=' . $options['destdata2']) : '').',channel=' . $trunk['trName'] . ((isset($trunk['coID']) && strlen(trim($trunk['coID'])) > 0) ? (',coID=' . trim($trunk['coID'])) : '') . '); ' . $callerID . ' Dial(SIP/' . $trunk['trName'] . '_' . $Aid . ',${dialtime},${optionsIn}); Hangup; ' . "\n";
                            }
                        }
                        else
                            $ael = '';
                    }
                    else
                        $ael = '';
                    break;
                //Terminate
                case '101404':
                    if($type == 'invalid_ivr')
                        $ael = 'disposition=FAILED; Hangup; ';
                    elseif($type != 'ivr')
                    {
                        $ael  = $defaultExten.' => { Hangup; }'."\n";
                        $ael .= '            h => &postCallincard(); ';
                    }
                    else
                        $ael    = ' Hangup; ';
                    break;
                //IVR
                case '101405':
                    if($type == 'invalid_ivr')
                        $ael  = '   MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_ivr_'.$options['destdata'].'_'.$Aid.',s,begin; ';
                    elseif($type != 'ivr')
                    {
                        $ael  = '   '.$defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_ivr_'.$options['destdata'].'_'.$Aid.',s,begin; Hangup;  }'."\n";
                        $ael .= '   h => &postCallincard(); ';
                    }
                    else
                        $ael  = '   MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_ivr_'.$options['destdata'].'_'.$Aid.',s,begin; Hangup;  ';

                    break;
                //Scenario
                case '101406':
                    $ael    = "";
                    break;
                //Record
                case '101407':
                    $record = call_Record_Name($Aid, $options['destdata'], $link);

                    if($type == 'invalid_ivr')
                        $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); Playback(${Record}'.$record.'); ';
                    elseif($type != 'ivr')
                    {
                        $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); Playback(${Record}'.$record.'); Hangup;  }'."\n";
                        $ael    .= '    h => &postCallincard(); ';
                    }
                    else
                        $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); Playback(${Record}'.$record.'); Hangup;  ';

                    break;
                //Custom destination
                case '101408':
                    if(isset($options['destdata']))
                    {
                        $cd = c_mysqli_call($link, 'ast_GetCustomDestinationClear', $Aid.', '.$options['destdata'].', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TRUE, "ASC", NULL, 0, NULL');
                        if(!isset($cd[0]['exten']))
                            $cd[0]['exten'] = '${EXTEN}';
                        if(!isset($cd[0]['priority']))
                            $cd[0]['priority'] = '1';

                        if($type == 'invalid_ivr')
                        {
                            if(isset($cd[0]['context']) && strlen($cd[0]['context'])>0)
                                $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto '.$cd[0]['context'].'|'.$cd[0]['exten'].'|'.$cd[0]['priority'].'; ';
                            else
                                $ael = '';
                        }
                        elseif($type != 'ivr')
                        {
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto '.$cd[0]['context'].'|'.$cd[0]['exten'].'|'.$cd[0]['priority'].'; Hangup; } '."\n";
                            $ael    .= '        h => &postCallincard(); ';
                        }
                        else
                        {
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto '.$cd[0]['context'].'|'.$cd[0]['exten'].'|'.$cd[0]['priority'].'; Hangup;  ';
                        }
                    }
                    break;
                //Trunk pool
                case '101409':
                    $trunks = call_Pool_Name($Aid, $options['destdata'], $link);
                    $trunker = [];
                    if(count($trunks)>0)
                    {
                        if(!isset($options['prefix']))
                            $options['prefix'] = '';
                        else
                            $options['prefix'] = ':'.$options['prefix'];
                        if(!isset($options['prepend']))
                            $options['prepend'] = '';
                        foreach ($trunks as $key => $value)
                        {
                            $trunks[$key]['trName'] = $value['trName'] .'_'.$Aid;
                            if((isset($options['coID']) && strlen(trim($options['coID']))>0))
                                unset($trunks[$key]['coID']);
                            $trunker[] = $value['trName'] .'_'.$Aid;
                        }
                        /*print_r($trunks);
                        print_r($trunker);*/
                        if(isset($options['destdata2']) && strlen(trim($options['destdata2']))>0)
                            $number = $options['destdata2'];
                        else
                            $number = $options['prepend'].'${EXTEN'.$options['prefix'].'}';

                        if($type == 'invalid_ivr')
                        {
                            $ael .= '             &GetFreeDev('.implode('|', $trunker).',random); if("${free}" != "") { '."\n".'             Set(channel=${CUT(free,_,1)});'."\n";
                            foreach ($trunks as $data)
                            {
                                if(isset($data['coID']) && strlen(trim($data['coID']))>0)
                                    $ael .= '             if("${free}" = "'.$data['trName'].'") Set(coID='.trim($data['coID']).');'."\n";
                            }
                            $ael .= '             '.((isset($callerID) && strlen(trim($callerID))>0) ? ($callerID."\n") : '' ).'             Dial(SIP/${free}/'.$number.'); }'."\n";

                        }
                        elseif($type != 'ivr')
                        {
                            $ael = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : ''). ');'."\r\n";
                            $ael .= '             &GetFreeDev('.implode('|', $trunker).',random); if("${free}" != "") { '."\n".'             Set(channel=${CUT(free,_,1)});'."\n";
                            foreach ($trunks as $data)
                            {
                                if(isset($data['coID']) && strlen(trim($data['coID']))>0)
                                    $ael .= '             if("${free}" = "'.$data['trName'].'") Set(coID='.trim($data['coID']).');'."\n";
                            }
                            $ael .= '             '.((isset($callerID) && strlen(trim($callerID))>0) ? ($callerID."\n") : '' ).'             Dial(SIP/${free}/'.$number.'); }'."\n";
                            $ael .= '           Hangup; '."\n".'    }'."\n";
                            $ael .= '           h => &postCallincard(); ';
                        }
                        else
                        {
                            $ael = "\n";
                            $ael .= '             &GetFreeDev('.implode('|', $trunker).',random); if("${free}" != "") { '."\n".'             Set(channel=${CUT(free,_,1)});'."\n";
                            foreach ($trunks as $data)
                            {
                                if(isset($data['coID']) && strlen(trim($data['coID']))>0)
                                    $ael .= '             if("${free}" = "'.$data['trName'].'") Set(coID='.trim($data['coID']).');'."\n";
                            }
                            $ael .= '             '.((isset($callerID) && strlen(trim($callerID))>0) ? ($callerID."\n") : '' ).'             Dial(SIP/${free}/'.$number.'); }'."\n";
                            $ael .= '           Hangup; '."\n";
                        }
                    }
                    break;
                //Time Group
                case '101410':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        if($type == 'invalid_ivr')
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_time_'.$Aid.'_'.$options['destdata'].',${EXTEN},1;  ';
                        elseif($type != 'ivr')
                            $ael    = $defaultExten.' => { MSet(destination='.$destination.(isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_time_'.$Aid.'_'.$options['destdata'].'|${EXTEN}|1; Hangup; } '."\n";
                        else
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_time_'.$Aid.'_'.$options['destdata'].',${EXTEN},1; Hangup; ';
                    }
                    else
                        $ael = '';
                    break;
                //Callback
                case '101411':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        if($type == 'invalid_ivr')
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_callback_'.$Aid.'_'.$options['destdata'].',s,1;  ';
                        elseif($type != 'ivr')
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '') .'); goto db_callback_'.$Aid.'_'.$options['destdata'].'|s|1; Hangup; } '."\n";
                        else
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_callback_'.$Aid.'_'.$options['destdata'].',s,1; Hangup; ';
                    }
                    else
                        $ael = '';
                    break;
                //Conference
                case '101412':
                    if(isset($options['destdata']) && strlen(trim($options['destdata'])))
                    {
                        if($type == 'invalid_ivr')
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_conference_'.$Aid.','.$options['destdata'].',1;  ';
                        elseif($type != 'ivr')
                            $ael    = $defaultExten.' => { MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_conference_'.$Aid.','.$options['destdata'].',1; Hangup; } '."\n";
                        else
                            $ael    = ' MSet(destination='.$destination. (isset($options['destdata']) ? (',destdata='.$options['destdata']) : '') . (isset($options['destdata2']) ? (',destdata2='.$options['destdata2']) : '').'); goto db_conference_'.$Aid.','.$options['destdata'].',1; Hangup; ';
                    }
                    else
                        $ael = '';
                    break;
            }
            return $ael;
        }
    }

    function makeRegExp($prefixs)
    {
        $result = array();
        if(is_array($prefixs))
        {
            foreach ($prefixs as $prefix)
                $prefixs['length'][substr_count($prefix, 'X')][] = $prefix;

            foreach ($prefixs['length'] as $key => $list)
            {
                foreach ($list as $prefix)
                {
                    if($prefix[0] == '_')
                        $prefixs['result'][$key][] = substr($prefix,1, (strlen($prefix)-$key-1));
                    else
                        $prefixs['result'][$key][] = substr($prefix,0, (strlen($prefix)-$key));
                }

            }
            foreach ($prefixs['result'] as $key => $list)
            {
                $list = array_unique($list);
                foreach ($list as $k => $str)
                    if(strlen(trim($str))==0)
                        unset($list[$k]);
                if($key > 0)
                    $result[] = '('.implode('|', $list).')[0-9]{'.$key.'}$';
                else
                    $result[] = '('.implode('|', $list).')$';
            }
            return str_replace('^()', '^', ('^'. implode('|^', $result)));
        }
        elseif(strlen(trim($prefixs))>0)
        {
            $count = substr_count($prefixs, 'X');
            if($prefixs == '_')
                $res = substr($prefixs,1, (strlen($prefixs)-$count-1));
            else
                $res = substr($prefixs,0, (strlen($prefixs)-$count));
            if($count>0)
                $res = '^('.$res.')[0-9]{'.$count.'}$';
            else
                $res = '^('.$res.')$';
            if(strpos('^'.$res, '(_)')>0)
                $result = str_replace('(_)', '', $res);
            elseif(strpos('^'.$res, '()')>0)
                $result = str_replace('()', '', $res);
            else
                $result = $res;
            if(strpos('^'.$result, '(_')>0)
                $result = str_replace('(_', '(', $res);
            return $result;
        }
        else
            return '';
    }

    function checkScript($script)
    {
        $cmd = 'ps ajxww | grep ' . $script . '$';
        echo $cmd."\r\n";
        $cmdResult = [];
        exec($cmd, $cmdResult);
        $countResult = count($cmdResult);
        if ($countResult > 0)
        {
            for ($i = 1; $i < $countResult; $i++)
            {
                $process = trim($cmdResult[$i]);
                $killCmd = 'kill -9 ' . explode(' ', $process)[1];
                exec($killCmd);
            }

            return true;
        }

        return false;
    }

?>