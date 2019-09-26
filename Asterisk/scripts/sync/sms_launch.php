<?php
    require_once 'functions.php';
    $scripts[] = 'sms_sender.php';
    $scripts[] = 'sms_receiver.php';
    $scripts[] = 'sms_bulk_parser.php';
    $path = '/var/www/html/hapi/log/sms';
    if(!is_dir($path)){
        mkdir($path);
    }

    foreach ($scripts as $script)
    {
        if(checkScript($script) == false)
        {
            $cmd = 'nice -20 php '. $script . ' 1>/dev/null 2>&1 &';
            echo "-> " . $cmd . "\n";
            $fp = popen($cmd, 'r');
            pclose($fp);
            echo 'Script "'.$script.'" launched'."\r\n";
        }
        else
        {
            echo 'Script "'.$script.'" already launched'."\r\n";
        }
    }

?>
