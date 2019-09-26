#!/bin/bash
iptables -A INPUT -s 146.0.82.10 -m comment --comment "Denis home" -j ACCEPT
#iptables -A INPUT -p tcp -m multiport --dports 80,81,3001,3000,3002,10050 -m comment --comment "ALLOW Web & WS" -j ACCEPT
#iptables -A INPUT -p udp --dport 5070 -m comment --comment "SIP" -j ACCEPT
service iptables save
systemctl restart fail2ban
