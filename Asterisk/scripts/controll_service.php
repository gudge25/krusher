<?php
//                      ?????? ? ??
$mhost = "localhost";
$muser = "asterisk_user";
$mpass = "rjgthybrec";
$mdb   = "asteriskdb";
$mysql = mysql_connect($mhost ,$muser, $mpass);
mysql_select_db($mdb,$mysql);
if(!$mysql) exit(BARADA);


$folder ="/etc/asterisk/";
$run    ="/usr/sbin/";
//------------------------------------------------------------------------------------------------------------------------------------------
function sipdb($ARG1,$ARG2) {
$file  = $ARG1."sip_db.conf";
$file3 = $ARG1."sip_temp";
//                      ???????? ???????
                        shell_exec("cat $file3 > $file ");
                        $query = mysql_query("SELECT * FROM sippeers INNER JOIN cityname on sippeers.name=cityname.name where cityname.city = 'kiev';");  // sippeers - ???????? ???????

                                while($row2 = mysql_fetch_array($query))
                                {
                                 $name=strtolower($row2['name']);
                                 file_put_contents("$file","[".$name."](".$row2['template'].")\n"                                               , FILE_APPEND);
                                 file_put_contents("$file","     secret=".$row2['secret'].  "\n"                                                , FILE_APPEND);
                                 file_put_contents("$file","     context=".$row2['context']. "\n"                                               , FILE_APPEND);
                                 file_put_contents("$file","     callgroup=".$row2['callgroup']. "\n"                                           , FILE_APPEND);
                                 file_put_contents("$file","     pickupgroup=".$row2['pickupgroup']. "\n"                                       , FILE_APPEND);
                                 file_put_contents("$file","     callerid=".$row2['callerid']. "\n"                                             , FILE_APPEND);
                                 file_put_contents("$file","\n"                                                                                 , FILE_APPEND);
                                }
exec($ARG2."asterisk -rx 'sip reload'");
}

//-------------------------------------------------------------------------------------------------------------------------------------------
function queues_conf($ARG1,$ARG2) {
$file  = $ARG1."queues_db.conf";
$file2 = $ARG1."queues_temp.conf";
exec("rm -f $file ");
exec("cat $file2 >> $file ");
      $query = mysql_query("SELECT usergroup.group,strategy from usergroup INNER JOIN incoming on usergroup.group=incoming.group  where incoming.extencity = 'kiev' or incoming.group >= 20000  group by usergroup.group;");
        while($row = mysql_fetch_array($query)) {
           $a=$row['group'];
           $strategy=$row['strategy'];
           $query2 = mysql_query("SELECT usergroup.name,usergroup.group,cityname.city FROM usergroup INNER JOIN sippeers on usergroup.name=sippeers.name INNER JOIN cityname on sippeers.name=cityname.name where usergroup.group = $a ORDER BY priority;");
                if($a == 5900 or $a == 6000) {
                   $shablon = "ringall";
                  }
                else {
                   $shablon = "linear";
                  }
                file_put_contents("$file","[$a]($shablon)                 \n",                                                               FILE_APPEND);
                file_put_contents("$file","strategy=$strategy                 \n",                                                               FILE_APPEND);
                while($row2 = mysql_fetch_array($query2)) {
                           if ($row2['city'] == 'kiev') {
                            if($a > 0 ) {
                              file_put_contents("$file","member => SIP/".$row2['name'].  "\n",                                                  FILE_APPEND);
                              }
                            else {
                            }
                          }
                          else {
                           if($a > 0 ) {
                              file_put_contents("$file","member => Local/".$row2['name']."@local-full" .  "\n",                                                  FILE_APPEND);
                              }
                            else { }
                          }
                 }
               file_put_contents("$file","\n"                                                                                            , FILE_APPEND);
  }
exec($ARG2."asterisk -rx 'queue reload all'");
}


//------------------------------------------------------

function extdb($ARG1) {
$file  = $ARG1."extensions_db.ael";
        exec("chmod 777 $file");
        $query = mysql_query("SELECT * FROM incoming where extencity = 'kiev' and `group` < 20000   group by `group`;");
        $query2 = mysql_query("SELECT * FROM incoming where `group` >= 20000   group by `group`;");
        exec("rm -f $file ");
        file_put_contents("$file","context db { \n", FILE_APPEND);
        file_put_contents("$file","\n", FILE_APPEND);
                        $mix="&mix2()";
                        $callerid="Set(CALLERID(num)=+380\${CALLERID(num)})";
                        $callerid2="Set(CALLERID(num)=+\${CALLERID(num)})";
                        while($row2 = mysql_fetch_array($query)) {
                        $a=$row2['group'];
                        $queue="Set(queuenum=$a)";
                        $exten=trim($row2['exten']);
                        $dialtime=$row2['dialtime'];
                        if ($row2['forward'] == 'hangup') {
                           $forward="Hangup";
                          }
                        else {
                           $forward="goto forward-context,".$row2['forward'].",begin";
                        }
                        if( $row2['group'] == 1000 )   {
                               $ael = "begin: Progress; $mix; $callerid;
                  Background(/var/lib/asterisk/sounds/bankaudio/hello_clients_usbbank); 
                  forward:
                  Queue(1000,Tt,,,$dialtime); $forward;" ;  }
                        elseif ( ($row2['group'] >= 8000) && ($row2['group'] <= 8700) )   {
                               $ael = "begin: Progress; $queue; $mix; $callerid2;
                  Background(/var/lib/asterisk/sounds/bankaudio/hello_clients_usbbank);
                  Background(/var/lib/asterisk/sounds/bankaudio/please_enter_number_or_wait_connection); WaitExten(14);
                  forward:
                  Queue($a,Tt,,,$dialtime); $forward;" ;   }
                        else { $ael = "begin: Progress; $mix; $callerid;
                  Background(/var/lib/asterisk/sounds/bankaudio/hello_clients_usbbank);
                  forward:
                  Queue($a,Tt,,,$dialtime); $forward;" ;    }
                        if ( $ael == "" ) exit(BARADA);

                        file_put_contents("$file",$exten." => { " .$ael." }\n", FILE_APPEND);
            }

        file_put_contents("$file","}\n\n\n", FILE_APPEND);
        file_put_contents("$file","context dial_local_queue { \n", FILE_APPEND);
        file_put_contents("$file","\n", FILE_APPEND);
                        $mix="&mix2()";
                        while($row2 = mysql_fetch_array($query2)) {
                        $a=$row2['group'];
                        $queue="Set(queuenum=$a)";
                        $exten=trim($row2['exten']);
                        $dialtime=$row2['dialtime'];
                        if ($row2['forward'] == 'hangup') {
                           $forward="Hangup";
                          }
                        else {
                           $forward="goto forward-context,".$row2['forward'].",begin";
                        }
                        if ($row2['group'] >= 20000)  {
                               $ael = "begin: Progress; $mix; forward: Queue($a,Tt,,,$dialtime); $forward;" ;   }
                        if ( $ael == "" ) exit(BARADA);
                        file_put_contents("$file",$exten." => { " .$ael." }\n", FILE_APPEND);
            }
        file_put_contents("$file","}\n", FILE_APPEND);

 }


//-----------------------------------------------


function hints($ARG1) {
$file   = $ARG1."extensions_transfer.ael";
exec("rm -f $file ");
$query = mysql_query("SELECT transfer.name from transfer INNER JOIN sippeers on transfer.name=sippeers.name INNER JOIN cityname on sippeers.name=cityname.name  where cityname.city='kiev' group by name;");
file_put_contents("$file","context local-transfer {\n\n", FILE_APPEND);
while($row = mysql_fetch_array($query)) {
$user=$row['name'];
$query2 = mysql_query("SELECT transfer from transfer INNER JOIN sippeers on transfer.name=sippeers.name INNER JOIN cityname on sippeers.name=cityname.name where sippeers.name = $user and cityname.city='kiev';");
                        $query4 = mysql_query("SELECT count(city) from cityname where name = $user;");
                        $row5 = mysql_fetch_array($query4);
                        if($row5['count(city)']==2) {
                           $ael="$user => { &mix2(); Dial(SIP/\${EXTEN}&SIP/odessa/\${EXTEN},\${dialtime-transfer},\${options-local});
                           if('\${DIALSTATUS}'='ANSWER') {Hangup;}";
                           file_put_contents("$file",$ael, FILE_APPEND);
                           usleep(10);}
                        else {
                           $ael="$user => { &mix2(); Dial(SIP/\${EXTEN},\${dialtime-transfer},\${options-local});
                           if('\${DIALSTATUS}'='ANSWER') {Hangup;}";
                           file_put_contents("$file",$ael, FILE_APPEND);
                           usleep(10);
                         }
                        while($row3 = mysql_fetch_array($query2)) {
                        file_put_contents("$file","  else \n", FILE_APPEND);
                        $user=strtolower($row3['transfer']);
                        if($user>=20000 and $user <= 30000) {
                           $ael="                    Dial(Local/$user@dial_local_queue,\${dialtime},\${options-local});
                           if('\${DIALSTATUS}'='ANSWER') {Hangup;}";
                           file_put_contents("$file",$ael, FILE_APPEND);
                           usleep(10);}
                       else {
                        $query3 = mysql_query("SELECT city from cityname where name = $user;");
                        while($row4 = mysql_fetch_array($query3)){
                          $city=$row4['city'];
                          if($city!='odessa') {
                            $ael="                    Dial(SIP/$user,\${dialtime-transfer},\${options-local});
                              if('\${DIALSTATUS}'='ANSWER') {Hangup;}";
                              file_put_contents("$file",$ael, FILE_APPEND);
                              usleep(10);}
                          else {
                             $ael="                    Dial(SIP/$city/$user,\${dialtime-transfer},\${options-local});
                              if('\${DIALSTATUS}'='ANSWER') {Hangup;}";
                              file_put_contents("$file",$ael, FILE_APPEND);
                              usleep(10);}
                        }
                        }
                        }
                        file_put_contents("$file","\n                              else   {Hangup;} \n", FILE_APPEND);
                        file_put_contents("$file","\n          } \n\n", FILE_APPEND);
    echo "done hints\n" ;
}
file_put_contents("$file","} \n", FILE_APPEND);


}

//------------------------------------------------
function localtrunk($ARG1) {
$file   = $ARG1."extensions_localtrunk.ael";
exec("rm -f $file ");
$query = mysql_query("SELECT sippeers.name from sippeers INNER JOIN cityname on sippeers.name = cityname.name  where cityname.city='odessa';");
file_put_contents("$file","context local-trunk {\n\n", FILE_APPEND);
while($row = mysql_fetch_array($query)) {
$user=$row['name'];
                        $ael="$user => { &mix2(); Dial(SIP/odessa/\${EXTEN},\${dialtime},\${options-local}); Hangup;} \n";
                        file_put_contents("$file",$ael, FILE_APPEND);
                        usleep(10);
    echo "done localtrunk \n" ;
}
file_put_contents("$file","} \n", FILE_APPEND);


}

//------------------------------------------------

function localkiev($ARG1) {
$file   = $ARG1."extensions_localkiev.ael";
exec("rm -f $file ");
$query = mysql_query("SELECT sippeers.name from sippeers INNER JOIN cityname on sippeers.name = cityname.name  where cityname.city='kiev';");
file_put_contents("$file","context local-kiev {\n\n", FILE_APPEND);
while($row = mysql_fetch_array($query)) {
$user=$row['name'];
 if($user == 90004) {
     $ael="$user => { &mix2(); Dial(SIP/\${EXTEN}&SIP/90245,\${dialtime},\${options-local}); Hangup;} \n";
  }
 else {
     $ael="$user => { &mix2(); Dial(SIP/\${EXTEN},\${dialtime},\${options-local}); Hangup;} \n";
 }
                        file_put_contents("$file",$ael, FILE_APPEND);
                        usleep(10);
    echo "done local-kiev \n" ;
}
file_put_contents("$file","} \n", FILE_APPEND);


}

//-------------STARTING---------------------------

//---SIP
$file5  = $folder."realtime-custom";
$query4 = mysql_query("SELECT usergroup.group from usergroup INNER JOIN incoming on usergroup.group=incoming.group  where incoming.extencity = 'kiev' group by usergroup.group;");
        while($row = mysql_fetch_array($query4)) {
                $b=$row['group'];
                $query5 = mysql_query("select name, count(id) as count from usergroup where `group` = $b;");
                while($row5 = mysql_fetch_array($query5)) {
                          $queue=$b;
                                if(trim($row5['count']) == trim(file_get_contents("$file5/$queue")))
                                {
                                        echo "SIP GROUP ".$b." and queues_conf not updated\n";
                                }
                                else
                                {       exec("rm -f $file5/$queue");
                                        file_put_contents("$file5/$queue",$row5['count']. "\n", FILE_APPEND);
                                        sipdb($folder,$run);                            // ??????? sip.conf
                                        queues_conf($folder,$run);                      // ??????? queus.conf
                                        $end=1;

                                        echo "SIP GROUP ".$b." and queues_conf reloaded\n";
                                        break;
                                }
                if(isset($end)) break;
                }
        }
//---SIP
$query7 = mysql_query("SELECT incoming.group FROM incoming where extencity = 'kiev' group by `group`;");
        while($row7 = mysql_fetch_array($query7)) {
                $b=$row7['group'];
                $query6 = mysql_query("select `group`, count(`group`) as count from incoming where `group` = $b;");
                while($row6 = mysql_fetch_array($query6))
                       {        $queue2="ael-".$b;
                                if(trim($row6['count']) == trim(file_get_contents("$file5/$queue2")))
                                {
                                        echo "AEL for Group ".$b." not updated\n";
                                }
                                else
                                {       exec("rm -f $file5/$queue2");
                                        file_put_contents("$file5/$queue2",$row6['count']. "\n", FILE_APPEND);
                                        extdb($folder);
                                        //extdbodessa($folder);
                                        hints($folder);
                                        localtrunk($folder);
                                        localkiev($folder);
                                        exec($run."asterisk -rx 'ael reload'"); echo "AEL for Group ".$b."reloaded\n";
                                        $end2=1;
                                        break;
                                }
                     if(isset($end2)) break;
             }
        }
mysql_close();
?>
