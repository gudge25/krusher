#!/bin/bash
#Install script for KRUSHER 64bit

# VARIABLES
export APP_DIR="/var/www/html"
export SRC_DIR="/usr/src/KRUSHER"
if [ ! -d "/var/www/" ]; then
  mkdir "/var/www/"
  if [ ! -d "${APP_DIR}" ]; then
    mkdir "${APP_DIR}"
  fi
fi

#Menu installation
#echo "Вкажіть модулі які будуть встановленні"
#echo "Натисніть 1 щоб встановити лише Астеріск"
#echo "Натисніть 3 щоб встановити крашер, астеріск та смс-сервер для goip"
#echo "Натисніть 4 щоб встановити астеріск та смс-сервер для goip"
#echo "Натисніть 5 щоб встановити смс-сервер для goip"
#echo "Натисніть 0 щоб прервати встановлення"

#echo "Выхотите начать? Введите 0"
#read choose
#export choose
#if [[ $choose -ne 0 ]] ; then
#    exit 1
#fi

#Write password to mysql
echo "Задайте пароль на mysql"
read passmysql
export passmysql

#install depends
echo "###########Запускаем файл depends.sh"
sh ${SRC_DIR}/sh/func/depends.sh #> /tmp/depends.log

#Random generate strong password to ami
echo "Задайте пароль на AMI"
amipass=$(pwgen 30 1)
echo ${amipass}
export amipass

#init var env
sh ${SRC_DIR}/sh/func/bashrc.sh

#install asterisk
echo "###########Запускаем файл install-asterisk.sh"
sh ${SRC_DIR}/sh/func/install-asterisk.sh #> /tmp/asterisk.log &

#INSTALL SQL
echo "###########Запускаем файл sql.sh"
sh ${SRC_DIR}/sh/func/sql.sh #> /tmp/depends.log

# пока не отладили в крон не ставим механизм
#yes | cp -pr ${SRC_DIR}/Asterisk/scripts/sync/krusher_cron /etc/cron.d/

#Copy files for work
echo "-----------------------------------------------------------------------"
echo "-----------               Устанавливаем hapi      ---------------------"
echo "-----------------------------------------------------------------------"
yes | cp ${SRC_DIR}/sh/hapi.sh ${APP_DIR}/
yes | cp -pr ${SRC_DIR}/hapi/ ${APP_DIR}/
mkdir ${APP_DIR}/hapi/uploads/
chmod -R 777 ${APP_DIR}/hapi/uploads/
yes | cp -pr ${SRC_DIR}/web/ ${APP_DIR}/

#init var env one more time
#start node
cd ${APP_DIR}/hapi
npm install
npm install request
npm link request
npm install glue
npm link glue
npm install lodash
npm link lodash
npm install should
npm link should
npm install susie
npm link susie
npm install uuid
npm link uuid
npm install hapi-cors-headers
npm link hapi-cors-headers
npm install hapi-emitter
npm link hapi-emitter
npm install li
npm link li
npm install inert
npm link inert
npm install vision
npm link vision
npm install mocha
npm link mocha
npm install hapi
npm link hapi
npm install hapi-auth-basic
npm link hapi-auth-basic
npm install mysql
npm link mysql
npm install hapi-plugin-websocket
npm link hapi-plugin-websocket
npm install hapi-router
npm link hapi-router
npm install hapi-swagger
npm link hapi-swagger
npm install asterisk-manager
npm link asterisk-manager
npm install good
npm link good
npm install q
npm link q
npm install joi
npm link joi
npm install json2xlsx
npm link json2xlsx
npm install js2xmlparser
npm link js2xmlparser
npm install node-xlsx
npm link node-xlsx
npm install good-squeeze
npm link good-squeeze
npm install good-console
npm link good-console
npm install ws
npm link ws
npm install boom
npm link boom
echo "-----------------------------------------------------------------------"
echo "-----------               Устанавливаем web       ---------------------"
echo "-----------------------------------------------------------------------"
cd ${APP_DIR}/web
npm install gulp-concat
npm link gulp-concat
npm install gulp-sourcemaps
npm link gulp-sourcemaps
npm install gulp-concat-css
npm link gulp-concat-css
npm install gulp-minify-css
npm link gulp-minify-css
npm install gulp-minify-html
npm link gulp-minify-html
npm install gulp-clean-css
npm link gulp-clean-css
npm install gulp
npm link gulp

echo "###########Запускаем файл build.sh"
sh ${SRC_DIR}/sh/func/build.sh #> /tmp/build.log

#TIMEZONE
echo "###########Запускаем файл ntp.sh"
sh ${SRC_DIR}/sh/func/ntp.sh &

#Making symlink to call records to theee web interface
echo "###########Запускаем файл simlink.sh"
sh ${SRC_DIR}/sh/func/simlink.sh &

HOSTNAME=$(hostname)
IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
JSON=$(cat <<EOF
{"channel": "#krusher_update", "username": "krusherbot", "text": "*CRM KRUSHER* installed on server *${HOSTNAME}* (${IP})" , "icon_emoji": ":flag-ua:"}
EOF
)
curl -X POST --data-urlencode "payload=${JSON}" https://hooks.slack.com/services/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

yes | cp -pr ${SRC_DIR}/sh/update.sh /usr/src/ &
yes | cp -pr ${SRC_DIR}/sh/ext_firewall.sh /usr/src/
sh ${SRC_DIR}/sh/firewall.sh &
#systemctl iptables stop


##### add server to zabbix
ZABBIXUSER='ApiUser'
ZABBIXPASS='gy8u4hgu548gj'
ZABBIXAPI='http://zabbix.asterisk.biz.ua/api_jsonrpc.php'

JSON=$(cat <<EOF
{"params":{"user":"${ZABBIXUSER}","password":"${ZABBIXPASS}"},"jsonrpc":"2.0","method":"user.login","id":1}
EOF
)
AUTHTOKEN=$(curl -X POST -H "content-type: application/json" -d "${JSON}" ${ZABBIXAPI} | jq ".result")
ADDHOST=$(cat << EOF
{
    "jsonrpc": "2.0",
    "method": "host.create",
    "params": {
        "host": "${HOSTNAME}.auto",
        "interfaces": [
            {
                "type": 1,
                "main": 1,
                "useip": 1,
                "ip": "${IP}",
                "dns": "",
                "port": "10050"
            }
        ],
        "groups": [
            {
                "groupid": "2"
            }
        ],
        "templates": [
            {
                "templateid": "10001"
            }
        ],
        "inventory_mode": 0,
        "inventory": {
            "macaddress_a": "01234",
            "macaddress_b": "56768"
        }
    },
    "auth": $AUTHTOKEN,
    "id": 1
}
EOF
)

echo "Adding to Zabbix"
add=$(curl -X POST -H "content-type: application/json" -d "${ADDHOST}" ${ZABBIXAPI})

echo "Install DONE!!"