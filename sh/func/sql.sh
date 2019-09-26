#!/bin/bash
#INSTALL SQL
#install lib
echo "-----------------------------------------------------------------------"
echo "-----------               Устанавливаем libs      ---------------------"
echo "-----------------------------------------------------------------------"
#tar xvzf ${SRC_DIR}/sql/lib64/lib_mysqludf_json-x86_64.tar.gz -C ${SRC_DIR}/sql/lib64/
#yes | cp ${SRC_DIR}/sql/lib64/lib_mysqludf_json.so /usr/lib64/mysql/plugin
source ~/.bashrc
#mysql -p${DB_PRD_PASS} < ${SRC_DIR}/sql/lib/lib_mysqludf_json.sql &
yes | unzip ${SRC_DIR}/sql/src/Data/Region/region.zip -d ${SRC_DIR}/sql/src/Data/
#cd ${SRC_DIR}/sql/src/Data/
#mysql -p${DB_PRD_PASS} krusher < region.sql 

#run build base DB
echo "-----------------------------------------------------------------------"
echo "-----------               Формируем DB          -----------------------"
echo "-----------------------------------------------------------------------"
cd ${SRC_DIR}/sql/
sh db-prd.sh ${DB_PRD_NAME} || { echo >&2 "failed with $?"; exit 1; }

#install sql common-scheme
echo "-----------------------------------------------------------------------"
echo "-----------       Ставим common-scheme          -----------------------"
echo "-----------------------------------------------------------------------"
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/common-schema/common_schema-2.2.sql
mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} < common_schema-2.2.sql
echo "--------------------      SQL заехал          -------------------------"