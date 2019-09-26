
<?php

    function checkScript($script)
    {
        $cmd = 'ps ajxww | grep ' . $script . '$';
        $cmdResult = [];
        exec($cmd, $cmdResult);
        $countResult = count($cmdResult);
        if ($countResult > 0) {
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

    function runScripts()
    {
        $cmdRes = 'cd /usr/src/KRUSHER/Asterisk/scripts/meduchet/';
        $script = 'meduchet.php';
        if (!checkScript($script))
        {
            $cmd = $cmdRes .' && php '. $script . ' &';
            //echo $cmd."\r\n";
            exec($cmd);
        }
        exit();
    }

    runScripts();
    exit();
?>


