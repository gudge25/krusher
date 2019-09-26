wBasic SIP useful feature list:

 * sip.conf                 : Основные настройки для SIP записей
 * sip_peers.conf           : SIP транки, GSM шлюзы и другие вендоры
 * sip_users.conf           : SIP пользователи
 * sip_webrtc.conf          : WevRTC SIP пользователи

Basic EXTENSIONS useful feature list:

 * extensions.ael           : Основные настройки и контексты
 * extensions_incoming.ael  : Входящие маршруты
 * extensions_outgoing.ael  : Исходящие маршруты
 * extensions_macros.ael    : Макросы

Basic QUEUES useful feature list:

 * queues.conf              : Настройки для очереди

Basic AMI/ARI/AGI useful feature list:

 * manager.conf             : Настройки для AMI
 * http.conf                : Настройки для HTTP
 * ari.conf                 : Настройки для ARI


run code! :+1:

```javascript

# pkill node
# cd /var/www/html/develop/ && rm -rf * 
# git clone -b dev git@bitbucket.org:demelopteam/krusher.git 
# sh krusher/Asterisk/install.sh 
# node krusher/api/bin/www >> /var/www/html/develop/krusher/web/log 2>&1

```
 
 ```crontab
 */2 * * * * root php /var/www/html/develop/crusher/Asterisk/scripts/sync/start.php
 ```