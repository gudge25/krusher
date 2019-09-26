#!/bin/bash
echo "-----------------------------------------------------------------------"
echo "-----------             Работает db-build.sh      ---------------------"
echo "-----------------------------------------------------------------------"
mkdir -p ${APP_DIR}/sql
mkdir -p ${APP_DIR}/sql/dist
cd ${APP_DIR}/sql
rm -f dist/*.sql
cat ${SRC_DIR}/sql/src/Create/CreateRole.sql ${SRC_DIR}/sql/src/Create/DatabaseOptions.sql >> ${APP_DIR}/sql/dist/000-create.sql
cat ${SRC_DIR}/sql/src/Code/*/*.sql ${SRC_DIR}/sql/src/Code/*/*/*.sql >> ${APP_DIR}/sql/dist/300-code.sql
cat ${SRC_DIR}/sql/src/DDL/*.sql >> ${APP_DIR}/sql/dist/100-ddl.sql
cat ${SRC_DIR}/sql/src/Data/InitialData/*.sql >> ${APP_DIR}/sql/dist/400-data.sql
cat ${APP_DIR}/sql/dist/*.sql >> ${APP_DIR}/sql/dist/production.sql
cat ${SRC_DIR}/sql/src/migration/*.sql >> ${APP_DIR}/sql/dist/migration.sql
echo "-----------------------------------------------------------------------"
echo "-----------             Собрал дампы              ---------------------"
echo "-----------------------------------------------------------------------"
