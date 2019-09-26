<?php
    // --- MYSQL ---
    $mysql_link = mysqli_connect(getenv('DB_PRD_HOST'), getenv('DB_PRD_USER'), getenv('DB_PRD_PASS'));
    mysqli_set_charset( $mysql_link, 'utf8' );
    mysqli_select_db($mysql_link, getenv('DB_PRD_NAME'));

    if(!$mysql_link)
        exit('MySQL сould not be connected');

    // --- Variable ---
    $folder     = "/etc/asterisk/";   //Asterisk conf folder
    $run        = "/usr/sbin/";       //Asterisk run folder
    $fop2folder = "/usr/local/fop2/"; // FOP2

    function clear($a)
    {
        mysqli_use_result($a);
        mysqli_next_result($a);
    }

    function quit(){
         exit('All process done'."\r\n");
    }

    function checkFile($command, $in_data = null, $out_data = null)
    {
        if(isset($in_data) && isset($out_data))
        {
            if(count($in_data) != count($out_data))
                $result = $command;
            else
            {
                $diff = false;
                if(empty($in_data) && !empty($out_data))
                    $diff = true;
                elseif(!empty($in_data) && empty($out_data))
                    $diff = true;
                else
                {
                    if ($in_data !== $out_data)
                        $diff = true;
                }
                if($diff)
                    $result = $command;
                else
                    $result = 'no changes';
            }
        }
        else
            $result = 'no changes';
        return $result;
    }

    function getTime()
    {
        $time = number_format(microtime(true), 4, '.', '');
        $time = explode('.', $time);

        return date('Y-m-d H:i:s', $time[0]) . '.' . $time[1];
    }
?>