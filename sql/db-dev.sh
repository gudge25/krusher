#!/bin/bash

sh db-build.sh

db=$1
echo "-----------------------------------------------------------------------"
echo "-----------             Все удаляем если есть     ---------------------"
echo "-----------------------------------------------------------------------"
mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} -e "DROP DATABASE IF EXISTS $db;CREATE DATABASE $db COLLATE UTF8_GENERAL_CI;"
echo "-----------------------------------------------------------------------"
echo "-----------             Заливаем сборку           ---------------------"
echo "-----------------------------------------------------------------------"
mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < ${APP_DIR}/sql/dist/production.sql
echo "-----------------------------------------------------------------------"
echo "-----------             Залили                    ---------------------"
echo "-----------------------------------------------------------------------"

#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/100-ddl.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/200-fks.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/300-code.sql
#mysql -u${DB_DEV_USER} -p${DB_DEV_PASS} -h${DB_DEV_HOST} $db < dist/400-data.sql



