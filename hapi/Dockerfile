# Use an official Node runtime as a parent image
FROM node:8-alpine
#-slim
#-alpine

WORKDIR /usr/src/app
RUN npm install --global yarn && apk add --no-cache wget \
&& wget -O project.tar.gz https://gitlab.com/api/v4/projects/3505263/repository/archive?private_token=kAjh8yaVtqykTxcEaNir \
&& tar -xzf project.tar.gz \
&& cp -R KRUSHER-dev-*/web . \
&& cd web/ \
&& yarn install 
# Create app directory
WORKDIR /usr/src/app/hapi

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
#COPY package*.json ./
#COPY package.json ./
#init
#&& rm -rf /var/lib/apt/lists/*
#RUN apt update && apt-get install apt-transport-https nano  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt update && apt-get install yarn && yarn install
#RUN npm install
#RUN npm install --global yarn &&  yarn install
# If you are building your code for production
#RUN npm install --only=productionmc

# Copy All in cur Dir
COPY . .

#RUN npm install
RUN  yarn install

ENV NODE_HOST=0.0.0.0
ENV NODE_PORT=3000
ENV NODE_PATH='.'
ENV NODE_ENV=production

ENV DB_PRD_USER=root
ENV DB_PRD_PASS=passmysql
ENV DB_PRD_HOST=localhost
ENV DB_PRD_NAME=krusher

ENV DB_DEV_USER=root
ENV DB_DEV_PASS=passmysql
ENV DB_DEV_HOST=localhost
ENV DB_DEV_NAME=krusher

ENV AMI_DEV_USER=krusher
ENV AMI_DEV_PORT=5039
ENV AMI_DEV_HOST=localhost
ENV AMI_DEV_PASS=amipass

ENV AMI_PRD_USER=krusher
ENV AMI_PRD_PORT=5039
ENV AMI_PRD_HOST=localhost
ENV AMI_PRD_PASS=amipass

EXPOSE 3000
CMD [ "npm", "start" ]

#TODO /etc/asterisk/extensions/global.ael  curl to test HApi