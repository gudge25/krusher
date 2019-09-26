#!/bin/bash
#Install script for asterisk 64bit
VERSION=13
DIR=/usr/src

#Remove asterisk
export mda2=${DIR}/asterisk-${VERSION}*
if [ ! -L ${mda2} ]; then
    echo "=> File asterisk doesn't exist"
else
    echo "=> File asterisk exist"
    cd ${DIR}/asterisk-${VERSION}* && make uninstall && make uninstall-all
    rm -rf /usr/src/asterisk-${VERSION}*
fi

#Download asterisk
cd ${DIR}
#ping -c2 downloads.asterisk.org > /dev/null && (wget -O if downloads.asterisk.org ; grep "asterisk: It works" < if && wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${VERSION}-current.tar.gz || { echo >&2 "failed with wget asterisk $?"; exit 1; } || echo "AHTUNG: site is not available") || echo "AHTUNG: server not available"
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-${VERSION}-current.tar.gz || { echo >&2 "failed with wget asterisk $?"; exit 1; }
#wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-11.25.3.tar.gz || { echo >&2 "failed with wget asterisk $?"; exit 1; }

tar xvzf asterisk-${VERSION}-current.tar.gz

#Install asterisk
cd asterisk-${VERSION}.*
make clean
contrib/scripts/get_mp3_source.sh
./configure --libdir=/usr/lib64 --with-jansson-bundled
# ./configure --libdir=/usr/lib64 --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect --enable-category MENUSELECT_ADDONS --disable BUILD_NATIVE --enable format_mp3
make && make install && make config && make install-logrotate

#Configure asterisk
echo "        secret          = ${amipass}" >> ${SRC_DIR}/Asterisk/manager.conf
yes | cp -r ${SRC_DIR}/Asterisk/* /etc/asterisk/

systemctl start asterisk
systemctl enable asterisk