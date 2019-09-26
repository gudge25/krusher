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
	//HTTP  headers
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
	$db2 = mysqli_connect($HOST, $USER, $PASS);
	mysqli_select_db($db2, $DB);
	mysqli_set_charset($db2, 'utf8');

	//CDR settings
	if(isset($_GET['sip']) && $_GET['sip'] != 'undefined' && !empty($_GET['sip']))
		$sip = " and (src=" .$_GET['sip']. " OR dst=" .$_GET['sip']. " OR dstchannel like '%/" .$_GET['sip']. ".-.%' )" ;
	else
		$sip 	= "";
	$limit = 1000000000;
	$a 		= isset($_GET['from']) ? $_GET['from'] : '';
	$b 		= isset($_GET['to']) ? $_GET['to'] : '';
	$d 		= ' calldate between  "' .$a. '" and "' .$b. '" ';
	$c		= " AND dst not in ('h') ";

	if(isset($_GET['sip_out'][0]) && $_GET['sip_out'] != 'undefined' && !empty($_GET['sip_out']))
	{
		foreach($_GET['sip_out'] as $key =>$value)
		{
			if($key == 0)
				$sip_out = "'". $value ."'";
			else
				$sip_out =  $sip_out . ",'". $value ."'";
		}
		$e	= " AND (src NOT IN (" .  $sip_out . ") and dst NOT IN (" .  $sip_out . ") )" ;

	}
	else
	    $e	= "";

	RestGET($db2, 'cdr','SELECT *, DATE_FORMAT(calldate,\'%d %b %H:%i\') AS nicedate, duration - billsec AS servicelevel FROM cdr WHERE ' . $d . $sip . $c. $e.' limit '.$limit.';');

	//Get column name
	RestGET($db2, 'cdr_column','SHOW COLUMNS FROM `cdr`;');


	 //GET URL for RecordsFile
	if(isset($_GET['url']))
	{
	    print $RecordsFile;
	}

	//Save comment to cdr
	//RestGET($db2, 'cdr_save', 'UPDATE cdr SET comment="' . isset($_GET['comment']) ? $_GET['comment'] : ''. '" WHERE uniqueid = "' . isset($_GET['uniqueid']) ? $_GET['uniqueid'] : ''. '" ;');

	//RestPOST('post','select 1;');

	//QUEUE LOG
    $from 		= isset($_GET['from']) ? $_GET['from'] : '';
    $to 		= isset($_GET['to']) ? $_GET['to'] : '';
	$select = 'SELECT agent, queuename, COUNT(agent) COUNT, SUM(data1) SUM FROM queue_log WHERE event = "CONNECT" AND time > "'. $from .'" AND time < "'. $to .'"  group by agent;';

	//echo $select;
	RestGET($db2, 'queue', $select);

	//get Active call
	RestGET($db2, 'active', 'call cdr_active();');


	mysqli_close($db2);

?>


