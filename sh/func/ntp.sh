#!/bin/bash
ln -s -f /usr/share/zoneinfo/Europe/Kiev /etc/localtime
service ntpd stop
#ntpdate pool.ntp.org
service ntpd start
systemctl enable ntpd.service
echo "Установлен часовой пояс Kiev"
date
