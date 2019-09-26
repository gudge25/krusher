# VARIABLES
APP_DIR="/var/www/html"
SRC_DIR="/usr/src/KRUSHER"

#Copy files for work
yes | cp ${SRC_DIR}/sh/hapi.sh ${APP_DIR}/
yes | cp -pr ${SRC_DIR}/hapi ${APP_DIR}/
yes | cp -pr ${SRC_DIR}/web ${APP_DIR}/
rpm -qa | grep -i webmin

#init var env one more time
source ~/.bashrc

#start node
cd ${APP_DIR}/hapi
npm install
cd ${APP_DIR}/web
npm install gulp gulp-concat gulp-sourcemaps gulp-concat-css gulp-minify-html gulp-clean-css
npm link gulp && gulp
sh ${APP_DIR}/hapi.sh stop
sh ${APP_DIR}/hapi.sh start

yes | cp -pr ${SRC_DIR}/sh/update.sh /usr/src/

curl -X POST --data-urlencode 'payload={"channel": "#krusher_update", "username": "webhookbot", "text": "*CRM KRUSHER* just installed on server * $HOSTNAME *", "icon_emoji": ":flag-ua:"}' https://hooks.slack.com/services/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