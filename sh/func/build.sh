#!/bin/bash
touch /etc/systemd/system/krusher.service
chmod 664 /etc/systemd/system/krusher.service
echo "[Unit]" > /etc/systemd/system/krusher.service
echo "Description=Krusher" >> /etc/systemd/system/krusher.service
echo "After=network-online.target" >> /etc/systemd/system/krusher.service
echo "" >> /etc/systemd/system/krusher.service
echo "[Service]" >> /etc/systemd/system/krusher.service
echo "Type=oneshot" >> /etc/systemd/system/krusher.service
echo "User=root" >> /etc/systemd/system/krusher.service
echo "ExecStart=/usr/bin/sh /var/www/html/hapi.sh start" >> /etc/systemd/system/krusher.service
echo "ExecStop=/usr/bin/sh /var/www/html/hapi.sh stop" >> /etc/systemd/system/krusher.service
echo "ExecReload=/usr/bin/sh /var/www/html/hapi.sh restart" >> /etc/systemd/system/krusher.service
echo "RemainAfterExit=true" >> /etc/systemd/system/krusher.service
echo "" >> /etc/systemd/system/krusher.service
echo "[Install]" >> /etc/systemd/system/krusher.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/krusher.service
echo "-----------------------------------------------------------------------"
echo "-----------               Запускаем hapi          ---------------------"
echo "-----------------------------------------------------------------------"
sed -i -e '/Defaults    requiretty/{ s/.*/# Defaults    requiretty/ }' /etc/sudoers
cd ${APP_DIR}/hapi
systemctl daemon-reload
systemctl stop krusher.service
pkill node
source ~/.bashrc
systemctl start krusher.service
systemctl enable krusher.service
echo "-----------------------------------------------------------------------"
echo "-----------               Запускаем web           ---------------------"
echo "-----------------------------------------------------------------------"
cd ${APP_DIR}/web/ && gulp &
systemctl status krusher.service

#if [ -f "/etc/rc.local" ]; then
#    echo "systemctl start krusher.service" >> /etc/rc.local
#else
#    echo "#!/bin/bash" > /etc/rc.local
#    echo "systemctl start krusher.service" >> /etc/rc.local
#fi
