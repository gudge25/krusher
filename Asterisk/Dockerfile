# Dockerfile Asterisk-13
FROM       debian:9-slim
LABEL maintainer="satskiy.a@gmail.com"

RUN apt-get update && apt-get install -y asterisk nano sngrep && rm -rf /var/lib/apt/lists/* && apt-get -y autoremove
COPY ./ /etc/asterisk

CMD ["asterisk","-cvv"]
## RUN wiith     docker run  -p 5070:5700 -d asterisk13new:latest 

# $mysql_link = mysqli_connect(getenv('DB_PRD_HOST'), getenv('DB_PRD_USER'), getenv('DB_PRD_PASS'));
#copy to /etc/asterisk