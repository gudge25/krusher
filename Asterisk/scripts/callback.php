<?php
$shortopts  = ""    ;
$longopts  = array(
        "num:",     // ???????????? ????????
        "sip:",
        "callerid:",
        "accountcode:",
        "type:",
        "free:",
        "mode:",
        "Queue:"
);

$options = getopt($shortopts, $longopts);
var_dump($options);
if(empty($options['num'])) exit();

        $server         ="localhost";
        $port           ="5039";
        $username       ="krusher";
        $secret         ="q8LuwG2IFkF0ktFeMLoII78vO4e3eI";
        $step           ="2000";
        $step2          ="1000";
        $timeout        ="100";
        $to             = $options['num'];
        $sip            = $options['sip'];
        $callerid       = $options['callerid'];
        $accountcode    = $options['accountcode'];
        $id             = $options['id'];
        $type           = $options['type'];
        $free           = $options['free'];
        $mode           = $options['mode'];
        $Queue          = $options['Queue'];

        $socket = fsockopen($server,$port, $errno, $errstr, $timeout);
usleep($step);
        fputs($socket, "Action: Login\r\n");
        fputs($socket, "UserName: $username\r\n");
        fputs($socket, "Secret: $secret\r\n\r\n");

echo "$to\r\n";
usleep($step);

        fputs($socket, "Action: Originate\r\n");
if( $mode == "2" ){
        fputs($socket, "Channel: LOCAL/". $sip ."@em_krus/n\r\n");
        fputs($socket, "Context:office\r\n");
        fputs($socket, "Exten: ". $to ."\r\n");
}
else
{
        fputs($socket, "Channel: LOCAL/". $to ."@office/n\r\n");
        fputs($socket, "Context:em_krus\r\n");
        fputs($socket, "Exten: ". $to ."\r\n");
}
        fputs($socket, "Account:" . $accountcode . "\r\n");
        fputs($socket, "Callerid: ".$callerid." <". $sip .">\r\n");
        fputs($socket, "Variable: id=" . $id . "\r\n");
        fputs($socket, "Variable: Type=" . $type . "\r\n");
        fputs($socket, "Variable: sip=" . $sip . "\r\n");
        fputs($socket, "Variable: phone=" . $to . "\r\n");
        fputs($socket, "Variable: free=" . $free . "\r\n");
        fputs($socket, "Variable: Queue=" . $Queue . "\r\n");
        fputs($socket, "Priority:1\r\n\r\n");


fputs($socket, "Action: Logoff\r\n");
sleep(5);
fclose($socket);
exit();

?>