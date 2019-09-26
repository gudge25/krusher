
#!/bin/bash
# Script will install ram disk on  Centos 7
banner(){
reset
echo ""
echo ""
echo ""
echo "Welcome to the ramdisk installation script!           "
echo "                                                    "
echo "WARNING !!!!!  IT SHOULD WORK  ONLY  ON CENTOS 7 DIST !!!!!"
echo "================================================================================"
echo ""
echo ""

}
banner
#//TODO check OS VERSION
echo "Please enter Ram amount to use in KB for this server: "
echo "for 2GB use 2097152  "
echo "for 1GB use 1048576  "
read ramdiskamount
#initialize Ramdisk
/usr/sbin/modprobe brd rd_nr=1 rd_size=$ramdiskamount max_part=0
#Format ramDisk
/sbin/mke2fs -q -m 0 /dev/ram0
#mkdir for Ram
/usr/bin/mkdir /mnt/rd
#mount to directory
/bin/mount /dev/ram0 /mnt/rd
#Enable rc.local and add data 
/usr/bin/chmod +x /etc/rc.d/rc.local
/usr/bin/systemctl enable rc-local
/usr/bin/systemctl start rc-local
echo "/usr/sbin/modprobe brd rd_nr=1 rd_size=$ramdiskamount max_part=0" >> /etc/rc.local
echo "/sbin/mke2fs -q -m 0 /dev/ram0" >> /etc/rc.local
echo "/bin/mount /dev/ram0 /mnt/rd" >> /etc/rc.local
#Comment exit if exist  
sed -e '/exit/ s/^#*/#/' -i /etc/rc.local
echo "ramDiskCreated"