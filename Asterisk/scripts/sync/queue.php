<?php
    function queuedb($ARG1, $ARG2, $link)
    {
        $file       = $ARG1."queue/db_queues.conf";
        $file2      = $ARG1."queue/temp.conf";
        $result     = mysqli_query($link,"SELECT * FROM ast_queues WHERE Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) AND isActive = TRUE;") or die("Query fail: " . mysqli_error($link));
        $num_rows   = mysqli_num_rows($result);

        $out_data = $in_data = [];
        if(file_exists($file))
            $in_data = file($file);
        exec("rm -f $file ");
        exec("cat $file2 >> $file ");
        if ($num_rows > 0)
        {
            while($row = mysqli_fetch_array($result))
            {
                $queID                              = $row['queID'];
                $Queue	                            = $row['queID'];
                $QueueName                          = $row['name'];
                $strategy                           = $row['strategy'];
                $shablon                            = 'queues';
                $music                              = 'default';
                $ringinuse                          = $row['ringinuse'];
                $wrapuptime                         = $row['wrapuptime'];
                $timeout                            = $row['timeout'];
                $retry                              = $row['retry'];
                $servicelevel                       = $row['servicelevel'];
                $joinempty                          = $row['joinempty'];
                $leavewhenempty                     = $row['leavewhenempty'];
                $memberdelay                        = $row['memberdelay'];
                $timeoutrestart                     = $row['timeoutrestart'];
                $announce                           = $row['announce'];
                $musiconhold                        = $row['musiconhold'];
                $queue_youarenext                   = $row['queue_youarenext'];
                $queue_thereare                     = $row['queue_thereare'];
                $queue_callswaiting                 = $row['queue_callswaiting'];
                $queue_holdtime                     = $row['queue_holdtime'];
                $queue_minutes                      = $row['queue_minutes'];
                $queue_seconds                      = $row['queue_seconds'];
                $queue_lessthan                     = $row['queue_lessthan'];
                $queue_thankyou                     = $row['queue_thankyou'];
                $queue_reporthold                   = $row['queue_reporthold'];
                $announce_frequency                 = $row['announce_frequency'];
                $announce_round_seconds             = $row['announce_round_seconds'];
                $announce_holdtime                  = $row['announce_holdtime'];
                $maxlen                             = $row['maxlen'];
                $eventmemberstatus                  = $row['eventmemberstatus'];
                $eventwhencalled                    = $row['eventwhencalled'];
                $reportholdtime                     = $row['reportholdtime'];
                $weight                             = $row['weight'];
                $periodic_announce                  = $row['periodic_announce'];
                $periodic_announce_frequency        = $row['periodic_announce_frequency'];
                $setinterfacevar                    = $row['periodic_announce_frequency'];

                file_put_contents($file,"[$Queue]($shablon)         ;--$QueueName--;                                                 \n",FILE_APPEND);
                file_put_contents($file,"   strategy=$strategy                                                                       \n",FILE_APPEND);
                if($musiconhold)                file_put_contents($file,"   musicclass=$musiconhold                                  \n",FILE_APPEND);
                if($ringinuse)                  file_put_contents($file,"   ringinuse=$ringinuse                                     \n",FILE_APPEND);
                if($wrapuptime)                 file_put_contents($file,"   wrapuptime=$wrapuptime                                   \n",FILE_APPEND);
                if($timeout)                    file_put_contents($file,"   timeout=$timeout                                         \n",FILE_APPEND);
                if($retry)                      file_put_contents($file,"   retry=$retry                                             \n",FILE_APPEND);
                if($servicelevel)               file_put_contents($file,"   servicelevel=$servicelevel                               \n",FILE_APPEND);
                if($joinempty)                  file_put_contents($file,"   joinempty=$joinempty                                     \n",FILE_APPEND);
                if($leavewhenempty)             file_put_contents($file,"   leavewhenempty=$leavewhenempty                           \n",FILE_APPEND);
                if($memberdelay)                file_put_contents($file,"   memberdelay=$memberdelay                                 \n",FILE_APPEND);
                if($timeoutrestart)             file_put_contents($file,"   timeoutrestart=$timeoutrestart                           \n",FILE_APPEND);
                if($announce)                   file_put_contents($file,"   announce=$announce                                       \n",FILE_APPEND);
                if($queue_youarenext)           file_put_contents($file,"   queue_youarenext=$queue_youarenext                       \n",FILE_APPEND);
                if($queue_thereare)             file_put_contents($file,"   queue_thereare=$queue_thereare                           \n",FILE_APPEND);
                if($queue_callswaiting)         file_put_contents($file,"   queue_callswaiting=$queue_callswaiting                   \n",FILE_APPEND);
                if($queue_holdtime)             file_put_contents($file,"   queue_holdtime=$queue_holdtime                           \n",FILE_APPEND);
                if($queue_minutes)              file_put_contents($file,"   queue_minutes=$queue_minutes                             \n",FILE_APPEND);
                if($queue_seconds)              file_put_contents($file,"   queue_seconds=$queue_seconds                             \n",FILE_APPEND);
                if($queue_lessthan)             file_put_contents($file,"   queue_lessthan=$queue_lessthan                           \n",FILE_APPEND);
                if($queue_thankyou)             file_put_contents($file,"   queue_thankyou=$queue_thankyou                           \n",FILE_APPEND);
                if($queue_reporthold)           file_put_contents($file,"   queue_reporthold=$queue_reporthold                       \n",FILE_APPEND);
                if($announce_frequency)         file_put_contents($file,"   announce_frequency=$announce_frequency                   \n",FILE_APPEND);
                if($announce_round_seconds)     file_put_contents($file,"   announce_round_seconds=$announce_round_seconds           \n",FILE_APPEND);
                if($announce_holdtime)          file_put_contents($file,"   announce_holdtime=$announce_holdtime                     \n",FILE_APPEND);
                if($maxlen)                     file_put_contents($file,"   maxlen=$maxlen                                           \n",FILE_APPEND);
                if($eventmemberstatus)          file_put_contents($file,"   eventmemberstatus=$eventmemberstatus                     \n",FILE_APPEND);
                if($eventwhencalled)            file_put_contents($file,"   eventwhencalled=$eventwhencalled                         \n",FILE_APPEND);
                if($reportholdtime)             file_put_contents($file,"   reportholdtime=$reportholdtime                           \n",FILE_APPEND);
                if($weight)                     file_put_contents($file,"   weight=$weight                                           \n",FILE_APPEND);
                if($periodic_announce)          file_put_contents($file,"   periodic_announce=$periodic_announce                     \n",FILE_APPEND);
                if($periodic_announce_frequency)file_put_contents($file,"   periodic_announce_frequency=$periodic_announce_frequency \n",FILE_APPEND);
                if($setinterfacevar)            file_put_contents($file,"   setinterfacevar=$setinterfacevar                         \n",FILE_APPEND);

                //Add member from while
                $query = "SELECT * FROM ast_queue_members WHERE queID = $queID AND emID IN (SELECT emID FROM emEmploy WHERE IsActive=TRUE) AND isActive = TRUE AND Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE);";
                $query3 = mysqli_query($link, $query) or die("Query fail: " . mysqli_error());
                $num_rows2   = mysqli_num_rows($query3);
                if ($num_rows2 > 0)
                    while($row3 = mysqli_fetch_array($query3))
                        if($Queue)
                            file_put_contents($file,"   member => ".$row3['interface'].'_'.$row3['Aid'].  "\n",FILE_APPEND);
            }
            echo 'queuedb: created "'.$file .'"'."\n";
            if(file_exists($file))
                $out_data = file($file);
        }
        mysqli_next_result($link);
        mysqli_free_result($result);

        //return checkFile($ARG2."asterisk -rx 'queue reload all'", $in_data, $out_data);
        return checkFile($ARG2."asterisk -rx 'queue reload all'", [1], []);
    }
?>