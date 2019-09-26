<?php
include '../../settings.php';

//Include FUNCTION
include 'functions.php';
//GLOBAL INI SETTING
ini_set("memory_limit", "3200M");
ini_set('max_execution_time', 300);
//HTTP headers
Header("Content-Type: text/html;charset=UTF-8");
header('Access-Control-Allow-Origin: *');
//HTTP headers
cors();
        if(isset($_GET['update']))
        {
                $appdir_web =  $appdir . "/WEB";
                shell_exec("cd $appdir");
                shell_exec("chown apache. -R $appdir");

                shell_exec("rm -f cdr.tar.gz");
                shell_exec("wget http://asterisk.biz.ua/app/cdr.tar.gz  -O cdr.tar.gz && tar xvzf cdr.tar.gz");
                exit("Updated");
        }

//CONNECT TO DB
$db2 = mysql_connect($HOST,$USER,$PASS);
mysql_select_db($DB);
mysql_set_charset('utf8');

//CDR settings
if(isset($_GET['sip']) && $_GET['sip'] != 'undefined' && !empty($_GET['sip']))
        $sip = " and (src=" .$_GET['sip']. " OR dst=" .$_GET['sip']. " OR dstchannel like '%/" .$_GET['sip']. ".-.%' )" ;
else
        $sip    = "";
$limit = 1000000000;
$a              = $_GET['from'];
$b              = $_GET['to'];
$d              = ' calldate between  \' ' .$a. ' \' and \' ' .$b. ' \' ';
$c              = " AND dst not in ('h') ";
if(isset($_GET['sip_out'][0]) && $_GET['sip_out'] != 'undefined' && !empty($_GET['sip_out']))
{
foreach($_GET['sip_out'] as $key =>$value)
{
        if($key == 0) $sip_out = "'". $value ."'";
        else    $sip_out =  $sip_out . ",'". $value ."'";
}
$e      = " AND (src NOT IN (" .  $sip_out . ") and dst NOT IN (" .  $sip_out . ") )" ;

}
else $e = "";

RestGET('cdr','SELECT *, DATE_FORMAT(calldate,\'%d %b %H:%i\') AS nicedate,duration - billsec as servicelevel from cdr WHERE ' . $d . $sip . $c. $e.' limit '.$limit.';');

//Get column name
RestGET('cdr_column','SHOW COLUMNS FROM `cdr`;');


 //GET URL for RecordsFile
if(isset($_GET['url'])) {       print $RecordsFile;             }

//Save comment to cdr
RestGET('cdr_save','UPDATE cdr SET comment=\'' .$_GET[comment]. '\' where uniqueid = \'' .$_GET[uniqueid]. '\' ;');

//RestPOST('post','select 1;');

//QUEUE LOG
$from         = $_GET['from'];
$to           = $_GET['to'];
$select='SELECT agent,queuename,count(agent) as count, sum(data1) as sum from queue_log where event = \'CONNECT\' and time > \''. $from .'\' and time < \''. $to .'\'  group by agent;';

//echo $select;
RestGET('queue',$select);

//get Active call
RestGET('active','call  cdr_active();');
mysql_close($db2);
?>