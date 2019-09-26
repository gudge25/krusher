# Use an official Node runtime as a parent image
#FROM node:10-alpine
FROM node:lts-alpine
#-slim
#-alpine

# Create app directory
WORKDIR /usr/src/app/web

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
#COPY package.json ./
#init
#&& rm -rf /var/lib/apt/lists/*
#RUN apt update && apt-get install apt-transport-https nano  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt update && apt-get install yarn && yarn install
#RUN npm install
RUN npm install --global yarn &&  yarn install
# If you are building your code for production
#RUN npm install --only=production

# Bundle app source
COPY . .

CMD [ "npm", "start" ]
