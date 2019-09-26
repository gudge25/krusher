#!/usr/bin/env bash
set -e
echo "==IMPORT  SQL TO  DATABASE=== "
echo "                                                    "
/usr/bin/mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < ./sql/dist/prod/production.sql
/usr/bin/mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < ./sql/dist/prod/common_schema-2.2.sql
#Coment Line Below for  use  MYSQL locally
exit $?


