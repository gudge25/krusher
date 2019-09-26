<?php
// 			Конект к ДБ
$mhost = "192.168.10.3";
$muser = "asterisk";
$mpass = "78945612Qwe";
$mdb   = "AsteriskDB";
$mssql = mssql_connect($mhost ,$muser, $mpass);
mssql_select_db($mdb,$mssql);
if(!$mssql) exit(BARADA);
//			Проверка на изменения
$file2  = "/etc/asterisk/sip_diff";
$query3 = mssql_query("select count(*) from sippeers where name not like '[789][0-9][0-9]%'");
$row3   = mssql_fetch_array($query3);


$query33 = mssql_query("select count(*) from exten_incoming");
$row33   = mssql_fetch_array($query33);
$file22 = "/etc/asterisk/diff";
//------------------------------------------------------------------------------------------------------------------------------------------
function sipdb()
{$file  = "/etc/asterisk/sip_db.conf";
 $file3 = "/etc/asterisk/sip_temp";
//			Создание конфига
			shell_exec("cat $file3 > $file ");
			$file3 = "/usr/local/fop2/buttons-trunk.cfg";
			$query = mssql_query("SELECT * FROM AsteriskDB..queue_member q join AsteriskDB..sippeers s on q.membername = s.name where name not like '[789][0-9][0-9]%'");
				

				while($row2 = mssql_fetch_array($query))
				{
				 $name=strtolower($row2['name']);
				 file_put_contents("$file","[".$name."](user2)\n"													, FILE_APPEND);
				 file_put_contents("$file","     context=".$row2['context']. "\n"									, FILE_APPEND);
				 file_put_contents("$file","     username=".$name. "\n"												, FILE_APPEND);
				 file_put_contents("$file","     callerid=".$name." <".$name.">\n"									, FILE_APPEND);
                 file_put_contents("$file","\n"																		, FILE_APPEND);
				}                
exec("asterisk -rx 'sip reload'");
}

function fop2()
{$file  = "/usr/local/fop2/buttons_from_queue_member.cfg";
 $file3 = "/usr/local/fop2/buttons-trunk.cfg";
 exec("rm -f $file ");
 
$query = mssql_query("SELECT i.psname, * FROM AsteriskDB..queue_member q join AsteriskDB..sippeers s on q.membername = s.name left join ( select * from ipname) i on i.ip = s.ipaddr;");
                while($row2 = mssql_fetch_array($query))
                       {
							if( $row2['queue_name'] == 5000 ) echo $row2['interface'],"---------------\n";
						
						file_put_contents("$file","[".strtolower($row2['interface'])."]\n"                                    	, FILE_APPEND);
                        file_put_contents("$file","     type=extension\n"                                         				, FILE_APPEND);
						file_put_contents("$file","     context=office\n"														, FILE_APPEND);
                        file_put_contents("$file","     extension=".strtolower(str_replace('SIP/','',$row2['interface']))."\n"	, FILE_APPEND);
                        file_put_contents("$file","     spyoptions=".strtolower($row2['interface'])."\n"                      	, FILE_APPEND);
                        file_put_contents("$file","     label=\n"								, FILE_APPEND); 
                        file_put_contents("$file","     group=".$row2['queue_name']."\n"										, FILE_APPEND);
                        file_put_contents("$file","\n"																			, FILE_APPEND);
						usleep(10);
                       }
                exec("cat $file3 >> $file ");
echo "Fop2 buttons added\n";               
}

function fop2_group()
{$a      = 1000;
 $trunks = "SIP/380170002509,SIP/MTC,SIP/KC,SIP/0443934736,SIP/0443934735,SIP/0443934734,SIP/0443934736-s,SIP/datagroup";
 $file   = "/usr/local/fop2/fop2.cfg";
  exec("sed -i '/^group=[1234567]:/d' $file ");
while($a <= 8000 )
{
$query4 = mssql_query("SELECT * FROM AsteriskDB..queue_member where queue_name = '$a'");
$b=$a/1000;
						if($a == 3000)
						{
						file_put_contents("$file","group=$b:$trunks,QUEUE/$a,QUEUE/2000,QUEUE/7000,"								, FILE_APPEND);
						$query2 = mssql_query("SELECT * FROM AsteriskDB..queue_member where queue_name like '[237]000'");
						while($row2 = mssql_fetch_array($query2))
						file_put_contents("$file","".strtolower($row2['interface']). ","										, FILE_APPEND);
                        file_put_contents("$file","\n"																			, FILE_APPEND);	
						}
						else
						{
						file_put_contents("$file","group=$b:$trunks,QUEUE/$a,"													, FILE_APPEND);
						while($row4 = mssql_fetch_array($query4))
						file_put_contents("$file","".strtolower($row4['interface']). ","										, FILE_APPEND);
                        file_put_contents("$file","\n"																			, FILE_APPEND);		
						}
$a=$a+1000;
}
echo "Fop2 group added\n";
}

function queues_conf()
{
$file  = "/etc/asterisk/queues_db.conf";
$file2 = "/etc/asterisk/queues_temp.conf";
$a     = 1000;
exec("rm -f $file ");
exec("cat $file2 >> $file ");
	while($a<=8000)
	{
	$query = mssql_query("SELECT * FROM AsteriskDB..queue_member where queue_name = '$a'");
							file_put_contents("$file","[$a](queues)\n"												, FILE_APPEND);
								while($row = mssql_fetch_array($query))
								{
								if($row['membername'] > 0 ){
									file_put_contents("$file","member => ".$row['interface']. "\n"					, FILE_APPEND);
									}
									else
									{
									file_put_contents("$file","member => ".strtolower($row['interface']).",0,".strtolower($row['membername']). "\n"	, FILE_APPEND);
									}
								}
	$a=$a+1000;
	}
exec("asterisk -rx 'queue reload all'");	
echo "Queues reloaded\n";
}

function extdb()
{
$file  = "/etc/asterisk/db.ael";

        exec("chmod 777 $file");
        $query = mssql_query("select * FROM exten_incoming");
        exec("rm -f $file ");
        file_put_contents("$file","context db { \n", FILE_APPEND);
        file_put_contents("$file","\n", FILE_APPEND);

		  $userevent="UserEvent(incoming,\"Channel: \${CHANNEL}\",\"Exten: \${EXTEN}\",\"Uniqueid: \${UNIQUEID}\",\"Callerid: \${CALLERID(num)}\");";
          $first="&user(\${EXTEN}); Macro(acode); &mix2();";
		  $office6="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office6\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { Macro(time1-2); Hangup; }";
		  $office5="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office5\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { Dial(SIP/\${chkoffice},60,\${options}); Hangup; }";
		  $office8="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office8\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { Queue(8000); Hangup; }";
		  
		  $office2="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office2\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { goto incoming|0443640711|1; Hangup; }";
		  $office3="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office3\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { goto incoming|0443641840|1; Hangup; }";
		  $office4="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office4\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { goto incoming|0443641836|1; Hangup; }";
		  $office7="Set(chkoffice=\${CUT(SHELL(grep '\${CALLERID(num)}' \${FILECDR} | grep -wo \"\^\.\*office7\$\" | tail -1),\,,1)}); if( '\${chkoffice}' != '' ) { goto incoming|0443641800|1; Hangup; }";
		  
			while($row2 = mssql_fetch_array($query))
            {
			if( $row2['group'] == 1000 ) { $ael = "$userevent $first $office6 $office2 $office3 $office4 $office7 $office5 $office8 Macro(time); Hangup;";}
			if( $row2['group'] == 2000 ) { $ael = "$userevent $first Macro(time2); Hangup;" ;}
			if( $row2['group'] == 3000 ) { $ael = "$userevent $first Macro(time3); Hangup;" ;}
			if( $row2['group'] == 4000 ) { $ael = "$userevent $first Macro(time4); Hangup;" ;}
			if( $row2['group'] == 5000 ) { $ael = "$userevent Macro(acode); &mix2(); if(\${DB_EXISTS(list/0504490957)}=1) { Dial(Local/0504490957@office5); Hangup;} Macro(time5);   Hangup;";}
			if( $row2['group'] == 7000 ) { $ael = "$userevent $first Macro(time7); Hangup;" ;}
			if( $row2['group'] == 8000 ) { $ael = "$first Queue(8000); Hangup;" ;}
			if( $row2['group'] == "BLOCKED" ) { $ael = "Answer; CDR(accountcode)=BLOCKED; Hangup;" ;}
			if( $row2['group'] == "CALLBACK" ) { $ael ="EXT=\${CALLERID(num)}; CDR(accountcode)=\${EXTEN}; NoCDR; System(php /etc/asterisk/callback.php --num '\${EXT}' \&); Congestion(0);" ;}
			if( $row2['group'] == "CUSTOM" ) { $ael = $ael = "$userevent $first Dial(SIP/vparmil); Hangup;" ;}
			
			if ( $ael == "" ) exit(BARADA);

			file_put_contents("$file",$row2['exten']." => { " .$ael." }\n", FILE_APPEND);
            }
        file_put_contents("$file","}\n", FILE_APPEND);

        exec("asterisk -rx 'ael reload'");
        echo "AEL reloaded\n";
        
                mssql_close();
 }

 function spark()
 {
 $query = mssql_query("SELECT name FROM AsteriskDB..queue_member q join AsteriskDB..sippeers s on q.membername = s.name where name not like '[789][0-9][0-9]%';");

				while($row = mssql_fetch_array($query))
				{
				$user=$row['name'];
				echo file_get_contents(
				$file = "http://192.168.10.12:9090/plugins/userService/userservice?type=add&secret=fdMO1bDG&username=$user&password=1111&groups=pilotu",
				$use_include_path = false);
				}
 }
//------------------------------------------------------------------------------------------------------------------------------------------





//-------------STARTING-------------	
	  if($row3['0'] == file_get_contents("$file2")) 
		   { 
			echo "SIP         not updated\n";
			echo "fop2        not updated\n";
			echo "queues_conf not updated\n";
			}
      else {
			exec("rm -f $file2 ");
			file_put_contents("$file2",$row3['0']);	
			
			sipdb();          	// Создаем sip.conf
			fop2();			  	// Ресуем Кнопки для админки
			fop2_group();		// Добавляем права для админки
			queues_conf();		// Создаем queus.conf
			spark();            // Добавляем юзеров в OpenFire
			}	

      if($row33['0'] != file_get_contents("$file22"))
			{
			exit('AEL not updated');
			}
			else
			{
			file_put_contents("$file22",$row33['0']);
			extdb();
			}
		
mssql_close();
?>




 
