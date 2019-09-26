#!/bin/bash
echo "-----------------------------------------------------------------------"
echo "-----------               Работает db-prd.sh      ---------------------"
echo "-----------------------------------------------------------------------"
sh db-build.sh

db=$1

mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} -e "DROP DATABASE IF EXISTS $db;CREATE DATABASE $db COLLATE UTF8_GENERAL_CI;"
mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} $db < ${APP_DIR}/sql/dist/production.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/100-ddl.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/200-fks.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/300-code.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/400-data.sql

#mysqldump -ulgdmitry -h77.91.132.6 -p2wsxCDE32 -C --databases ross > ross.sql


#mysqldump -ulgdmitry -h77.91.132.6 -p2wsxCDE32 -C --add-drop-database --skip-comments region  > region.sql
