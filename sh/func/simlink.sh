#!/bin/bash
#Making symlink to call records to the web interface
echo "-----------------------------------------------------------------------"
echo "-----------               link to monitor         ---------------------"
echo "-----------------------------------------------------------------------"
export mda=${APP_DIR}/web/monitor
if [ ! -L $mda ]; then
       echo "=> File doesn't exist"
       ln -s -d /var/spool/asterisk/monitor/ ${APP_DIR}/web/
       echo "=> Created simlink done to monitor"
else
       echo "=> File MAONITOR exist"
fi

echo "-----------------------------------------------------------------------"
echo "-----------               link to RECORDS         ---------------------"
echo "-----------------------------------------------------------------------"
export mda=${APP_DIR}/web/records
if [ ! -L $mda ]; then
       echo "=> File doesn't exist"
       ln -s -d /var/www/html/hapi/uploads/records/ ${APP_DIR}/web/
       echo "=> Created simlink done to RECORDS"
else
       echo "=> File Records exist"
fi



echo "-----------------------------------------------------------------------"
echo "-----------               link to FOP3         ---------------------"
echo "-----------------------------------------------------------------------"
export mda=${APP_DIR}/web/fop2
if [ ! -L $mda ]; then
       echo "=> File fop2 doesn't exist"
       ln -s -d /var/www/html/fop2 ${APP_DIR}/web/
       echo "=> Created simlink done to FOP2"
else
       echo "=> File FOP2 exist"
fi

echo "-----------------------------------------------------------------------"
echo "-----------               link to RECORDS ZIP        ---------------------"
echo "-----------------------------------------------------------------------"
if [ ! -d "${APP_DIR}/hapi/download/" ]; then
  mkdir "${APP_DIR}/hapi/download/"
  if [ ! -d "${APP_DIR}" ]; then
    mkdir "${APP_DIR}"
  fi
fi
chmod -R 777 ${APP_DIR}/hapi/download/

export mda=${APP_DIR}/web/download
if [ ! -L $mda ]; then
       echo "=> File doesn't exist"
       ln -s -d /var/www/html/hapi/download/ ${APP_DIR}/web/
       echo "=> Created simlink done to RECORDS ZIP"
else
       echo "=> File Records ZIP exist"
fi