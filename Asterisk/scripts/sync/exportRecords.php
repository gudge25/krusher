<?php
    // --- Include ---
    require_once 'settings.php';
    // --- Include function---
    require_once 'functions.php';
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
        $result = c_mysqli_call($mysql_link, 'cc_GetExportRecordsListClear', '"'.date("Y-m-d H:i:s", strtotime("-1 week")).'", "'. date("Y-m-d H:i:s", strtotime("+1 week")). '", 103801, TRUE, "ASC", NULL, NULL, 1');

        if(count($result)>0) {

            $query = 'UPDATE ccContactRecords SET statusReady = 103802 WHERE idCR = '.$result[0]['idCR'].';';
            $mysql_link->query($query);

            $result2 = c_mysqli_call($mysql_link, 'cc_GetContactClear', $result[0]['Aid'] . ', "' .
                $result[0]['DateFrom'] . '", "' .
                $result[0]['DateTo'] . '", ' .
                (strlen($result[0]['dcIDs']) > 0 ? ('"' . $result[0]['dcIDs'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['emIDs']) > 0 ? ('"' . $result[0]['emIDs'] . '"') : 'NULL') . ', ' .
                '7001, ' .
                (strlen($result[0]['ffIDs']) > 0 ? ('"' . $result[0]['ffIDs'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['isMissed']) > 0 ? ($result[0]['isMissed'] == 'TRUE' ? 'TRUE' : 'FALSE') : 'NULL') . ', ' .
                (strlen($result[0]['isUnique']) > 0 ? ($result[0]['isUnique'] == 'TRUE' ? 'TRUE' : 'FALSE') : 'NULL') . ', ' .
                (strlen($result[0]['CallTypes']) > 0 ? ('"' . $result[0]['CallTypes'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['ccNames']) > 0 ? ('"' . $result[0]['ccNames'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['channels']) > 0 ? ('"' . $result[0]['channels'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['comparison']) > 0 ? ('"' . $result[0]['comparison'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['billsec']) > 0 ? ('"' . $result[0]['billsec'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['clIDs']) > 0 ? ('"' . $result[0]['clIDs'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['IsOut']) > 0 ? ($result[0]['IsOut'] == 'TRUE' ? 'TRUE' : 'FALSE') : 'NULL') . ', ' .
                (strlen($result[0]['id_autodials']) > 0 ? ('"' . $result[0]['id_autodials'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['id_scenarios']) > 0 ? ('"' . $result[0]['id_scenarios'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['ManageIDs']) > 0 ? ('"' . $result[0]['ManageIDs'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['target']) > 0 ? ('"' . $result[0]['target'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['coIDs']) > 0 ? ('"' . $result[0]['coIDs'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['destination']) > 0 ? ('"' . $result[0]['destination'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['destdata']) > 0 ? ('"' . $result[0]['destdata'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['destdata2']) > 0 ? ('"' . $result[0]['destdata2'] . '"') : 'NULL') . ', ' .
                (strlen($result[0]['ContactStatuses']) > 0 ? ('"' . $result[0]['ContactStatuses'] . '"') : 'NULL') . ', ' .
                'TRUE, NULL, NULL, NULL, NULL');

            $importList = [];
            $path_tmp = '/tmp/archive';
            $path = '/var/www/html/hapi/download';
            if(!is_dir($path)){
                mkdir($path);
            }
            if(!is_dir($path_tmp)){
                mkdir($path_tmp);
            }
            $folderName = 'records_'.date("Y-m-d_H:i:s");
            $fileName = $result[0]['idCR'].'.zip';
            if(!is_dir($path_tmp.'/'.$folderName)){
                mkdir($path_tmp.'/'.$folderName);
            }
            $step = 100;
            $template_mp3 = 'ffmpeg -i {{source}} -acodec libmp3lame {{destination}}';//ffmpeg -i 1558086099.365.ogg -acodec libmp3lame /tmp/audio.mp3
            $template_wav = 'ffmpeg -i {{source}} {{destination}}';//ffmpeg -i 1558086099.365.ogg /tmp/audio.wav
            if(isset($result2) && count($result2)>0)
            {
                foreach ($result2 as $record)
                {
                    if(isset($result[0]['convertFormat']) && ($result[0]['convertFormat'] == 104001 || $result[0]['convertFormat'] == 104002))
                    {
                        $sourceFileName = explode('/', $record['LinkFile']);
                        if($result[0]['convertFormat'] == 104001)//mp3
                        {
                            $command = str_replace('{{source}}', '/var/spool/asterisk/monitor/'. $record['LinkFile'].'.ogg', $template_mp3);
                            $command = str_replace('{{destination}}', $path_tmp.'/'.$folderName.'/'. $sourceFileName[count($sourceFileName)-1].'.mp3', $command);
                            if (!file_exists($path_tmp.'/'.$folderName.'/'. $sourceFileName[count($sourceFileName)-1].'.mp3'))
                            {
                                exec($command);
                                echo 'Just converted '.$record['LinkFile'].'.ogg to '.$path_tmp.'/'.$folderName.'/'.$sourceFileName[count($sourceFileName)-1].'.mp3 ('.$command.')'."\r\n";
                            }
                        }
                        else//wav
                        {
                            $command = str_replace('{{source}}', '/var/spool/asterisk/monitor/'. $record['LinkFile'].'.ogg', $template_wav);
                            $command = str_replace('{{destination}}', $path_tmp.'/'.$folderName.'/'. $sourceFileName[count($sourceFileName)-1].'.wav', $command);
                            if (!file_exists($path_tmp.'/'.$folderName.'/'. $sourceFileName[count($sourceFileName)-1].'.wav'))
                            {
                                exec($command);
                                echo 'Just converted '.$record['LinkFile'].'.ogg to '.$path_tmp.'/'.$folderName.'/'.$sourceFileName[count($sourceFileName)-1].'.wav ('.$command.')'."\r\n";
                            }
                        }
                    }
                    else
                    {
                        if(count($importList) == $step)
                        {
                            $command = 'cp '.implode(' ', $importList).' '.$path_tmp.'/'.$folderName;
                            exec($command);
                            echo 'Just added '.count($importList).' records in '.$path_tmp.'/'.$folderName."\r\n";
                            unset($importList);
                        }
                        $importList[] = '/var/spool/asterisk/monitor/'. $record['LinkFile'].'.ogg';
                    }
                }
                if(count($importList) > 0 && ($result[0]['convertFormat'] == 104003 || strlen(trim($result[0]['convertFormat']))==0))
                {
                    $command = 'cp '.implode(' ', $importList).' '.$path_tmp.'/'.$folderName;
                    exec($command);
                    echo 'Just added '.count($importList).' records in '.$path_tmp.'/'.$folderName."\r\n";
                }
                //sleep(2);
                $query = 'UPDATE ccContactRecords SET link = "'.$fileName.'", statusReady = 103803 WHERE idCR = '.$result[0]['idCR'].';';
                $mysql_link->query($query);
                $command = 'zip -jrm '.$path_tmp.'/'.$fileName.' '.$path_tmp.'/'.$folderName.'/';
                echo $command."\r\n";
                exec($command);
                $command = 'yes | mv -f '.$path_tmp.'/'.$fileName.' '.$path.'/'.$fileName.' > /dev/null &';
                echo $command."\r\n";
                pclose(popen($command, 'r'));
            }
            else
            {
                $query = 'UPDATE ccContactRecords SET link = "no_data", statusReady = 103803 WHERE idCR = '.$result[0]['idCR'].';';
                $mysql_link->query($query);
            }
        }
        else
            $working = FALSE;
    }
    echo 'Done'."\r\n";

?>