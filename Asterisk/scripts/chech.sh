#!/bin/bash

#PHYSICAL=`grep -i "physical id" /proc/cpuinfo | sort -u | wc -l`



TO=dmitriyz@telemedia.net.ua
FROM=PBX2@telemedia.net.ua
CC=sk@telemedia.net.ua,antonn@telemedia.net.ua,nastya.neverovskaya@telemedia.net.ua,tatyana.teslyuk@telemedia.net.ua,kuznecovt@telemedia.ua

fop2() {
/usr/sbin/sendmail -G -i -f $FROM -- $TO << EOF123EOF
Subject: FOP2
FOP2 is working
EOF123EOF
}
fop2-down() {
/usr/sbin/sendmail -G -i -f $FROM -- $TO -cc $CC << EOF123EOF
Subject: FOP2
FOP2 is down now. It was restarted.
EOF123EOF
}
ast-down() {
/usr/sbin/sendmail -G -i -f $FROM -- $TO -cc $CC << EOF123EOF
Subject: ASTERISK
???????? $1 ????, ???????, ?????????? ...
EOF123EOF
}



ast-zombie() {
/usr/sbin/sendmail -G -i -f $FROM -- $TO -cc $CC << EOF123EOF
Subject: ASTERISK
???????? $1 ???? ?????, ?????????? ????????? ...
EOF123EOF
}

FOP=$(ps -A | grep fop2 | wc -l)
        if [ "$FOP" = '1' ]; then echo "FOP2 working !" ; else fop2-down; /etc/init.d/fop2 start;  fi

ASTER=$(ps aux | grep -c  "/usr/sbin/asterisk$")
		 if [ "$ASTER" != '0' ]; then echo "Asterisk working !";	else ast-down "???????";	echo "Asterisk DOWN!"; /usr/sbin/asterisk; fi

ASTER1000=$(ps aux | grep -c "1000/sbin/asterisk$")
                 if [ "$ASTER1000" != '0' ]; then echo "Asterisk working !";        else ast-down "1000";        echo "Asterisk DOWN!"; /opt/11_14_1/1000/sbin/asterisk; fi
ASTER2000=$(ps aux | grep -c "2000/sbin/asterisk$")
                 if [ "$ASTER2000" != '0' ]; then echo "Asterisk working !";        else ast-down "2000";        echo "Asterisk DOWN!"; /opt/11_14_1/2000/sbin/asterisk; fi
ASTER3000=$(ps aux | grep -c "3000/sbin/asterisk$")
                 if [ "$ASTER3000" != '0' ]; then echo "Asterisk working !";        else ast-down "3000";        echo "Asterisk DOWN!"; /opt/11_14_1/3000/sbin/asterisk; fi
ASTER4000=$(ps aux | grep -c "4000/sbin/asterisk$")
                 if [ "$ASTER4000" != '0' ]; then echo "Asterisk working !";        else ast-down "4000";        echo "Asterisk DOWN!"; /opt/11_14_1/4000/sbin/asterisk; fi
ASTER5000=$(ps aux | grep -c "5000/sbin/asterisk$")
                 if [ "$ASTER5000" != '0' ]; then echo "Asterisk working !";        else ast-down "5000";        echo "Asterisk DOWN!"; /opt/11_14_1/5000/sbin/asterisk; fi
ASTER6000=$(ps aux | grep -c "6000/sbin/asterisk$")
                 if [ "$ASTER6000" != '0' ]; then echo "Asterisk working !";        else ast-down "6000";        echo "Asterisk DOWN!"; /opt/11_14_1/6000/sbin/asterisk; fi
ASTER7000=$(ps aux | grep -c "7000/sbin/asterisk$")
                 if [ "$ASTER7000" != '0' ]; then echo "Asterisk working !";        else ast-down "7000";        echo "Asterisk DOWN!"; /opt/11_14_1/7000/sbin/asterisk; fi
ASTER8000=$(ps aux | grep -c "8000/sbin/asterisk$")
                 if [ "$ASTER8000" != '0' ]; then echo "Asterisk working !";        else ast-down "8000";        echo "Asterisk DOWN!"; /opt/11_14_1/8000/sbin/asterisk; fi
ASTER9000=$(ps aux | grep -c "9000/sbin/asterisk$")
                 if [ "$ASTER9000" != '0' ]; then echo "Asterisk working !";        else ast-down "9000";        echo "Asterisk DOWN!"; /opt/11_14_1/9000/sbin/asterisk; fi
ASTER10000=$(ps aux | grep -c "10000/sbin/asterisk$")
                 if [ "$ASTER10000" != '0' ]; then echo "Asterisk working !";       else ast-down "10000";        echo "Asterisk DOWN!"; /opt/11_14_1/10000/sbin/asterisk; fi



#ASTER0=$(ps aux | grep  "/usr/sbin/asterisk$" | grep -c SLsl)
#                 if [ "$ASTER0" == '1' ]; then echo "Asterisk working !";        else ast-zombie "???????";        echo "Asterisk ZOMBIE!";   fi
#
#ASTER1=$(ps aux | grep "1000/sbin/asterisk$" | grep -c SLsl)
#                 if [ "$ASTER1" == '1' ]; then echo "Asterisk working !";        else ast-zombie "1000";        echo "Asterisk ZOMBIE!";  fi
#ASTER2=$(ps aux | grep "2000/sbin/asterisk$" | grep -c SLsl)
#                 if [ "$ASTER2" == '1' ]; then echo "Asterisk working !";        else ast-zombie "2000";        echo "Asterisk ZOMBIE!";  fi
#ASTER3=$(ps aux | grep  "3000/sbin/asterisk$" | grep -c SLsl)
#                 if [ "$ASTER3" == '1' ]; then echo "Asterisk working !";        else ast-zombie "3000";        echo "Asterisk ZOMBIE!";  fi
#ASTER4=$(ps aux | grep "4000/sbin/asterisk$" | grep -c SLs )
#                 if [ "$ASTER4" == '1' ]; then echo "Asterisk working !";        else ast-zombie "4000";        echo "Asterisk ZOMBIE!";  fi
#ASTER5=$(ps aux | grep "5000/sbin/asterisk$" | grep -c SLs)
#                 if [ "$ASTER5" == '1' ]; then echo "Asterisk working !";        else ast-zombie "5000";        echo "Asterisk ZOMBIE!";  fi
#ASTER6=$(ps aux | grep "6000/sbin/asterisk$" | grep -c SLs)
#                 if [ "$ASTER6" == '1' ]; then echo "Asterisk working !";        else ast-zombie "6000";        echo "Asterisk ZOMBIE!";  fi
#ASTER7=$(ps aux | grep "7000/sbin/asterisk$" | grep -c SLs)
#                 if [ "$ASTER7" == '1' ]; then echo "Asterisk working !";        else ast-zombie "7000";        echo "Asterisk ZOMBIE!";  fi
#ASTER8=$(ps aux | grep "8000/sbin/asterisk$" | grep -c SLs)
#                 if [ "$ASTER8" == '1' ]; then echo "Asterisk working !";        else ast-zombie "8000";        echo "Asterisk ZOMBIE!";  fi
#ASTER9=$(ps aux | grep "9000/sbin/asterisk$" | grep -c SLs)
#                 if [ "$ASTER9" == '1' ]; then echo "Asterisk working !";        else ast-zombie "9000";        echo "Asterisk ZOMBIE!";  fi
#ASTER10=$(ps aux | grep "10000/sbin/asterisk$" | grep -c SLs)
#                 if [ "$ASTER10" == '1' ]; then echo "Asterisk working !";       else ast-zombie "10000";        echo "Asterisk ZOMBIE!"; fi



#sub='Asterisk SIP Line'
sub2='MsSQL SERVER'
sub3='HARDWARE STATUS'
sub4='WebRTC STATUS'
sub5='STUN STATUS'


SQLS2=$(echo "select 2;" | isql -v MSSQL-asterisk asterisk 78945612Qwe | grep -v select |grep -wo "2")
		if [ "$SQLS2" != '2' ]; then  (echo "Subject:$sub2"; echo "$SQLS2 Something wrong with MSSQL need to check it";) | sendmail -G -i -f $FROM -- $TO -cc $CC ;   fi

DF=$(df -lkP | grep -v devfs | grep -v none | grep -v Filesystem | grep "/dev/mapper/vg_pbx200-lv_root" | awk '{print $5}' | grep -wo ^..)
		if [ "$DF" -ge '90' ]; then  (echo "Subject:$sub3"; echo "$DF % Please clean the HDD now ! ";) | sendmail -G -i -f $FROM -- $TO -cc $CC ;   fi

FREEMB=$(free -m | grep buffers/cach | awk '{print $4}')
		if [ "$FREEMB" -le '400' ]; then  (echo "Subject:$sub3"; echo "$FREEMB MB Please clean the RAM now ! ";) | sendmail -G -i -f $FROM -- $TO -cc $CC ;   fi


WEBRTC=$(ifconfig | grep -woc 192.168.10.217)
		if [ "$WEBRTC" != '1' ];     then (echo "Subject:$sub4"; echo "$WEBRTC need to check WebRTC";) | sendmail -G -i -f $FROM -- $TO -cc $CC; fi

STUN=$(ps -A | grep -woc stun-server)
		if [ "$STUN" != '1' ];     then (echo "Subject:$sub5"; echo "$STUN need to check STUN service";) | sendmail -G -i -f $FROM -- $TO -cc $CC; fi

#echo "Physical CPUs : $PHYSICAL"
#echo $SQLS2
echo $CC
echo $FROM
echo $TO

