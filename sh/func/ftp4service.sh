FTP_SERVER=u208891.your-storagebox.de
FTP_USERNAME=u208891
FTP_PASSWORD=wCpo7ocWqEskM9Iz
#mkdir /ftp
curlftpfs -o user=${FTP_USERNAME}:${FTP_PASSWORD} "${FTP_SERVER}" /var/www/html/hapi/download
#Enter host password for user '${FTP_USERNME}':