#!/bin/bash
#Update script for KRUSHER 64bit
export APP_DIR="/var/www/html"
export SRC_DIR="/usr/src/KRUSHER"
 
git pull --force

# Remove old code
shopt -s extglob
cd  ${APP_DIR}/hapi && rm -rf !(node_modules|uploads|keys|download) && cd ${APP_DIR}/web && rm -rf !(node_modules) && rm -rf ${APP_DIR}/sql/dist

#Copy new code
shopt -s extglob
yes | cp -pr !(uploads|keys|download) ${SRC_DIR}/hapi ${APP_DIR}/ && yes | cp -pr ${SRC_DIR}/web ${APP_DIR}/ && yes | cp -pr ${SRC_DIR}/sql ${APP_DIR}/

#turn off default firewall
setenforce 0
sestatus

if [ ! -d "${APP_DIR}/sql/dist/" ]; then
    mkdir "${APP_DIR}/sql/dist/"
else
    rm -f ${APP_DIR}/sql/dist/*.sql
fi
cd ${APP_DIR}/sql
sh db-build.sh
mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} -D ${DB_PRD_NAME} < dist/300-code.sql          || { echo >&2 "failed with 2 $?"; exit 1; }
mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} -D ${DB_PRD_NAME} < dist/migration.sql         || { echo >&2 "failed with 1 $?"; exit 1; } &
 
cd ${APP_DIR}/web && yarn install
cd ${APP_DIR}/hapi && yarn install

echo "###########Запускаем файл build.sh"
sh ${SRC_DIR}/sh/func/build.sh &

#Making symlink to call records to theee web interface
echo "###########Запускаем файл simlink.sh"
sh ${SRC_DIR}/sh/func/simlink.sh &
if [ ! -d "${APP_DIR}/hapi/uploads/" ]; then
  mkdir "${APP_DIR}/hapi/uploads/"
  if [ ! -d "${APP_DIR}" ]; then
    mkdir "${APP_DIR}"
  fi
fi
chmod -R 777 ${APP_DIR}/hapi/uploads/

HOSTNAME=$(hostname)
IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
JSON=$(cat <<EOF
{"icon_emoji":":ghost:","text":"*CRM KRUSHER* updated on server *${HOSTNAME}* (${IP})","attachments":[]}
EOF
)
curl -X POST -H 'Content-Type: application/json' --data "${JSON}" https://chat.asterisk.biz.ua/hooks/kLhjgogrbrWyAvXpF/zc3FASvrmYoCWhNrvmA4APMf3kc35xj4Exc5d4QZFsCyGE9w

yes | cp -r ${SRC_DIR}/Asterisk/extensions.ael /etc/asterisk/extensions.ael
yes | cp -r ${SRC_DIR}/Asterisk/extensions/macros* /etc/asterisk/extensions/ && /usr/sbin/asterisk -rx 'ael reload'

sh ${SRC_DIR}/sh/firewall.sh &

echo "Update DONE!"