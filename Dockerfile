FROM ubuntu:18.04

MAINTAINER "Tien Vo" <tienvv.it@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /home/jenkins

RUN apt -q update \
    && apt install -y net-tools

# Set user jenkins to the image
RUN groupadd -g 117 jenkins \
    && useradd -g 117 -u 112 -d /home/jenkins -s /bin/sh jenkins \
    && echo "jenkins:jenkins" | chpasswd

# Volume for cache
VOLUME /home/jenkins

# Create cache home
RUN mkdir -p "/home/jenkins" \
    && chown jenkins:jenkins "/home/jenkins" \
    && chmod 0777 "/home/jenkins"

# run install git, curl 
RUN apt-get install -y build-essential git curl mysql-server \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn

RUN apt-get install -y redis-server libfontconfig
RUN sed -i '/^bind/s/bind.*/bind 0.0.0.0/' /etc/redis/redis.conf

ADD config/init-start.sh /init-start.sh
RUN chmod +x /init-start.sh
# Default command
ENTRYPOINT ["/init-start.sh"]

