#!/bin/bash
#Update script for KRUSHER 64bit
export APP_DIR="/var/www/html"
export SRC_DIR="/usr/src/KRUSHER"
export USER="AsteriskTester"
export PASS=$( echo "Um9kbWFuR2ZoamttMDk4Cg==" | base64 -d)
rm -rf ${SRC_DIR}
git clone -b master --depth=1 https://${USER}:${PASS}@gitlab.com/asterisktech/KRUSHER.git ${SRC_DIR} || { echo >&2 "failed with $?"; exit 1; }

# Remove old code
shopt -s extglob
cd  ${APP_DIR}/hapi && rm -rf !(node_modules|uploads|keys) && cd  ${APP_DIR}/web && rm -rf !(node_modules) && rm -rf ${APP_DIR}/sql/dist

#Copy new code
shopt -s extglob
yes | cp -pr !(uploads|keys) ${SRC_DIR}/hapi ${APP_DIR}/ && yes | cp -pr ${SRC_DIR}/web ${APP_DIR}/ && yes | cp -pr ${SRC_DIR}/sql ${APP_DIR}/

#turn off default firewall
setenforce 0
sestatus

# пока не отладили в крон не ставим механизм
#yes | cp -pr ${SRC_DIR}/Asterisk/scripts/sync/krusher_cron /etc/cron.d/

cd ${APP_DIR}/sql
mkdir ${APP_DIR}/sql/dist
rm -f ${APP_DIR}/sql/dist/*.sql
sh db-build.sh
mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} -D ${DB_PRD_NAME} < dist/migration.sql		|| { echo >&2 "failed with 1 $?"; exit 1; }
mysql -u${DB_PRD_USER} -p${DB_PRD_PASS} -h${DB_PRD_HOST} -D ${DB_PRD_NAME} < dist/300-code.sql		|| { echo >&2 "failed with 2 $?"; exit 1; } &
npm i -g npm
cd ${APP_DIR}/hapi && npm install

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
{"channel": "#krusher_update", "username": "krusherbot", "text": "*CRM KRUSHER* updated on server *${HOSTNAME}* (${IP})" , "icon_emoji": ":flag-ua:"}
EOF
)
curl -X POST --data-urlencode "payload=${JSON}" https://hooks.slack.com/services/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

#yes | cp -pr ${SRC_DIR}/sh/update.sh /usr/src/ &
yes | cp -r ${SRC_DIR}/Asterisk/extensions.ael /etc/asterisk/extensions.ael
yes | cp -r ${SRC_DIR}/Asterisk/extensions/macros* /etc/asterisk/extensions/ && /usr/sbin/asterisk -rx 'ael reload'

sh ${SRC_DIR}/sh/firewall.sh &

echo "Update DONE!"