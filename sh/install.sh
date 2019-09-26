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

#if [ -z "${DB_PRD_NAME}" ]; then
#Random generate strong password to ami
echo "Задайте пароль на AMI"
amipass=$(pwgen 30 1)
echo ${amipass}
export amipass

#init var env
sh ${SRC_DIR}/sh/func/bashrc.sh

#install asterisk
#echo "###########Запускаем файл install-asterisk.sh"
sh ${SRC_DIR}/sh/func/install-asterisk.sh > /tmp/asterisk.log

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
npm install --global yarn
npm install --global gulp
cd ${APP_DIR}/hapi
yarn install

echo "-----------------------------------------------------------------------"
echo "-----------               Устанавливаем web       ---------------------"
echo "-----------------------------------------------------------------------"
cd ${APP_DIR}/web
yarn install

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
{"icon_emoji":":ghost:","text":"*CRM KRUSHER* installed on server *${HOSTNAME}* (${IP})","attachments":[]}
EOF
)

curl -X POST -H 'Content-Type: application/json' --data '${JSON}' https://chat.asterisk.biz.ua/hooks/wwcGeY82YJjsbTsfT/68dzQv9hNg5hrQPTYszsXvhTdprNPJs8mrx7MAfihHcH7LRC

NEWHOSTNAME=$(cat <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 ${ZABBHOSTNAMEIXUSER}
EOF
)
echo "${NEWHOSTNAME}" > /etc/hosts
echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts

systemctl stop firewalld
systemctl disable firewalld
cp   /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sed -i 's/\(^ignoreip =\).*/\ignoreip = 127.0.0.1\/8 176.111.58.150 176.111.58.175 91.196.158.221 217.66.102.142 192.168.0.0\/16 10.0.0.0\/8 172.16.0.0\/12 /' /etc/fail2ban/jail.local
sed -i 's/\(^port     =\).*/\port     = 5070/' /etc/fail2ban/jail.local
sed -i '/\[asterisk\]/a\enabled = true' /etc/fail2ban/jail.local
systemctl enable fail2ban
systemctl start fail2ban

yes | cp -pr ${SRC_DIR}/sh/update.sh /usr/src/ &
systemctl enable iptables
yes | cp -pr ${SRC_DIR}/sh/ext_firewall.sh /usr/src/
sh ${SRC_DIR}/sh/firewall.sh &

echo  nameserver 8.8.8.8 > /etc/resolv.conf
echo  nameserver 8.8.4.4 >> /etc/resolv.conf

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

echo "Install DONE!!";

#else
#    echo "Не правильно создались переменные среды";
#fi