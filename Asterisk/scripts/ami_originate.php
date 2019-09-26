<?php
// SETTINGS
        $server     = "192.168.0.0";
        $port       = "5038";
        $username   = "wc";
        $secret     = "*****";
        $step       = "500";
        $step2      = "1000";
        $timeout    = "100";

        //GET INCOMING VAR
        $from       = $_GET['from'];
        $to         = $_GET['to'];

// CONNECT TO ASTERISK AMI
        $socket = fsockopen($server,$port, $errno, $errstr, $timeout);
        usleep($step);
        fputs($socket, "Action: Login\r\n");
        fputs($socket, "UserName: $username\r\n");
        fputs($socket, "Secret: $secret\r\n\r\n");

        echo "$to\r\n";
        usleep($step);

// ORIGINATE CALL
        fputs($socket, "Action: Originate\r\n");

        //FIRST LEG
        fputs($socket, "Channel: Local/". $to ."@office\r\n");
        fputs($socket, "Callerid: AutoCall <". $to .">\r\n");

        //SECOND LEG
        fputs($socket, "Exten: " . $from . "\r\n");
        fputs($socket, "Context: office\r\n");
        fputs($socket, "Account: AutoCall\r\n");
        fputs($socket, "Priority: 1\r\n\r\n");

fputs($socket, "Action: Logoff\r\n");
sleep(5);
fclose($socket);
exit();

?>
