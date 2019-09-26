#!/bin/bash

cd /usr/src
yum install glibc.i686 zlib-devel libgssapi_krb5.so.2 curl
wget http://118.142.51.162/update/goip_install-v1.22.tar.gz
tar -zxvf goip_install-v1.22.tar.gz
cd goip_install
sh goip_install.sh
/etc/init.d/httpd restart

# http://192.168.2.2/goip/en/dosend.php?USERNAME=root&PASSWORD=root&smsprovider=1&smsnum=13800138000&method=2&Memo=hello
# curl --data "USERNAME=root&PASSWORD=fysnf&smsprovider=3&smsnum=$client&method=2&Memo=$line$i" http://localhost/goip/en/dosend.php? > /dev/null 2>&1;