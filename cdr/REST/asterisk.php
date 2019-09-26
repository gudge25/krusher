<?php
//Restart
if(isset($_GET['restart'])) 			{  CLI('core restart now');			 	}
if(isset($_GET['gracefully'])) 			{  CLI('core restart gracefully'); 		}
if(isset($_GET['convenient'])) 			{  CLI('core restart when convenient');	}
 
//Stop
if(isset($_GET['stop'])) 				{  CLI('core stop now');			 	}
if(isset($_GET['stop_gracefully'])) 	{  CLI('core stop gracefully'); 		}
if(isset($_GET['stop_convenient'])) 	{  CLI('core stop when convenient'); 	}

//Start
if(isset($_GET['start'])) 		{  echo shell_exec("sudo /opt/env11_8_0/sbin/asterisk"); } 

//Abort
if(isset($_GET['abort'])) 		{  CLI('core abort shutdown'); }

//Reload
if(isset($_GET['reload'])) 		{  CLI('core reload'); }

//Uptine
if(isset($_GET['uptime'])) 		{  CLI('core show uptime');	}

//Calls
if(isset($_GET['calls'])) 		{  CLI('core show calls'); 	}
 
function CLI($ARG1){
	$ARG1_c = " -rx '$ARG1'";
	echo shell_exec("sudo /opt/env2/sbin/asterisk $ARG1_c");
	echo "finish";	
} 
 
?>
 



