#!/bin/bash
#Update and install depends Asterisk, ODBC, PHP
echo "-----------------------------------------------------------------------"
echo "----------------              Обновляем ОС        ---------------------"
echo "-----------------------------------------------------------------------"
yum update -y
yum upgrade -y
echo "-----------------------------------------------------------------------"
echo "----------------   Устанавливаем разные приблуды  ---------------------"
echo "-----------------------------------------------------------------------"
yum install -y iptables iptables-services libcurl-devel svn epel-release dmidecode ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel libuuid-devel unixODBC unixODBC-devel libtool-ltdl libtool-ltdl-devel bzip2 patch libedit-devel
yum install -y sudo net-tools nano mc vsftpd htop unzip git pwgen ntp tzdata gcc gcc-c++ make libsrtp-devel certbot zabbix22-agent bind-utils jq
yum install -y perl-Digest-MD5 perl-libwww-perl.noarch perl-Crypt-SMIME.x86_64 perl-LWP-Protocol-https perl-Crypt-SSLeay sox mpg123 jq fail2ban
#OGG format support asterisk & converter
yum install -y libvorbis-devel libogg-devel vorbis-tools ffmpeg ffmpeg-devel 

#zabbix config
sed -i 's/\(^Server=\).*/\Server=zabbix.asterisk.biz.ua/' /etc/zabbix_agentd.conf
systemctl enable zabbix-agent
systemctl start zabbix-agent

#turn off default firewall
setenforce 0
sestatus
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config

echo "-----------------------------------------------------------------------"
echo "----------                Устанавливаем PHP 7     ---------------------"
echo "-----------------------------------------------------------------------"
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum remove php* -y
yum install -y php71w-fpm php71w-redis mod_php71w php71w-cli php71w-common php71w-gd php71w-mbstring php71w-mcrypt php71w-mysqlnd php71w-xml -y
echo "установился PHP"
php -v

#mysql-connector-odbc
# echo "-----------------------------------------------------------------------"
# echo "-----------               Устанавливаем ODBC      ---------------------"
# echo "-----------------------------------------------------------------------"
# cd ${DIR}
# wget https://dev.mysql.com/get/Downloads/Connector-ODBC/5.3/mysql-connector-odbc-5.3.9-1.el7.x86_64.rpm
# yum -y localinstall --nogpgcheck mysql-connector-odbc-5.3.9-1.x86_64.rpm
# ln -s /usr/lib64/libmyodbc5w.so /usr/lib64/libmyodbc5.so
# echo "установился ODBC"

#Install NodeJS & npm
echo "-----------------------------------------------------------------------"
echo "-----------       Устанавливаем NodeJS and nmp    ---------------------"
echo "-----------------------------------------------------------------------"

yum erase /etc/yum.repos.d/nodesource-el.repo -y
curl -sL https://rpm.nodesource.com/setup_11.x | bash -
yum clean all
yum update -y
yum install nodejs -y
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
#curl -L https://npmjs.org/install.sh | sh && yum install npm -y
#yum install -y gcc-c++ make -y
npm i -g npm -y
echo "node"
node -v
echo "npm:"
npm -v

#Install MariaDB 10.2
echo "-----------------------------------------------------------------------"
echo "------------      Устанавливаем Марию Мускуловнy  ---------------------"
echo "-----------------------------------------------------------------------"
FileRepo=/etc/yum.repos.d/MariaDB.repo
echo "[mariadb]" > ${FileRepo}
echo "name = MariaDB" >> ${FileRepo}
echo "baseurl = http://yum.mariadb.org/10.3/centos7-amd64" >> ${FileRepo}
echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> ${FileRepo}
echo "gpgcheck=1" >> ${FileRepo}
yum -y install MariaDB-server MariaDB-client
echo "установилась Маша"
systemctl enable mariadb.service
systemctl start mariadb.service
mysqladmin password ${passmysql}
echo "-----------------------------------------------------------------------"
echo "------------          Запустилась MariaDB        ----------------------"
echo "-----------------------------------------------------------------------"
echo ""
echo ""
echo ""
echo "-----------------------------------------------------------------------"
echo "------------      Прикручиваем sngrep             ---------------------"
echo "-----------------------------------------------------------------------"
echo "[irontec]" > /etc/yum.repos.d/irontec.repo
echo "name=Irontec RPMs repository" >> /etc/yum.repos.d/irontec.repo
echo 'baseurl=http://packages.irontec.com/centos/$releasever/$basearch/' >> /etc/yum.repos.d/irontec.repo
rpm --import http://packages.irontec.com/public.key
yum install sngrep -y
yum update -y
yum upgrade -y