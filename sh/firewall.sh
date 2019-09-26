#!/bin/bash
## The list of IPs allowed to have full access to the box Add it in this form:
#176.111.58.150  #main ssh Gateway
#176.111.58.175  #main PBX server
#91.196.158.221  #office optica
#217.66.102.142  #office
#195.181.215.214 #zabbix
#95.158.55.4     #Zhdanov Dmitry Home
#134.249.181.70 #Zhdanov Dmitry Home Киевстар 
if [ -f "/usr/src/ext_firewall.sh" ]; then
    trusted_ips="
            176.111.58.150
            176.111.58.175
            91.196.158.221
            217.66.102.142
            192.168.0.0/16
            10.0.0.0/8
            172.16.0.0/12
            95.158.55.4
            195.181.215.214
            134.249.181.70
    "
    ### Please don't change anything below.
    ### -----------------------------------------------------###
    #### Some best-practices
    #### Flush Everything
    iptables -Z INPUT
    iptables -F INPUT
    iptables -Z FORWARD
    iptables -F FORWARD

    ## Firewall rules
    ## Drop invalid connections allow established ones and allow loopback
    iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A INPUT -i lo -j ACCEPT

    ## Allow full access from trusted IP
    for ok_ip in $trusted_ips
    do
        iptables -A INPUT -s "$ok_ip" -m comment --comment "ALLOW from list" -j ACCEPT
    done

    #iptables -A INPUT -p tcp -m multiport --dports 3001,3000,3002,10050,5070 -m comment --comment "ALLOW Web & WS" -j ACCEPT
    #iptables -A INPUT -p udp --dport 5070 -m comment --comment "SIP" -j ACCEPT
    #iptables -A INPUT -p tcp --dport 5061 -m comment --comment "SIP SRTP" -j ACCEPT

    iptables -A INPUT -p udp --dport 10000:20000 -m comment --comment "RTP traffic" -j ACCEPT
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT
    sh /usr/src/ext_firewall.sh &
else
    echo " "
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "                           FIREWALL is OFF                                   "
    echo "                           You need set local config                         "
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo " "
fi
#### Saving iptables rules