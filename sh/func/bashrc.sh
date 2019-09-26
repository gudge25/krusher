#!/bin/bash
echo "" >> ~/.bashrc
echo "#Node config" >> ~/.bashrc
echo "export NODE_ENV=production" >> ~/.bashrc
echo "export NODE_PORT=3000" >> ~/.bashrc
echo "export NODE_HOST=0.0.0.0" >> ~/.bashrc
echo "export NODE_PATH='.'" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "#DataBase config" >> ~/.bashrc
echo "export DB_PRD_USER=root" >> ~/.bashrc
echo "export DB_PRD_PASS=${passmysql}" >> ~/.bashrc
echo "export DB_PRD_HOST=localhost" >> ~/.bashrc
echo "export DB_PRD_NAME=krusher" >> ~/.bashrc

echo "export DB_DEV_USER=root" >> ~/.bashrc
echo "export DB_DEV_PASS=${passmysql}" >> ~/.bashrc
echo "export DB_DEV_HOST=localhost" >> ~/.bashrc
echo "export DB_DEV_NAME=krusher" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "#asterisk AMI config" >> ~/.bashrc
echo "export AMI_DEV_USER=krusher" >> ~/.bashrc
echo "export AMI_DEV_PORT=5039" >> ~/.bashrc
echo "export AMI_DEV_HOST=localhost" >> ~/.bashrc
echo "export AMI_DEV_PASS=${amipass}" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "export AMI_PRD_USER=krusher" >> ~/.bashrc
echo "export AMI_PRD_PORT=5039" >> ~/.bashrc
echo "export AMI_PRD_HOST=localhost" >> ~/.bashrc
echo "export AMI_PRD_PASS=${amipass}" >> ~/.bashrc

source ~/.bashrc