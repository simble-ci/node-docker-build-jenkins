FROM ubuntu:16.04

MAINTAINER "Tien Vo" <tienvv.it@gmail.com>

# Add locales after locale-gen as needed
# Upgrade packages on image
# Preparations for sshd
RUN locale-gen en_US.UTF-8 \
    && apt-get -q update \
    && apt-get install -y net-tools \
    software-properties-common python-software-properties

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# run install git, curl 
RUN apt-get update && apt-get install -y curl mysql-server \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

ADD config/init-start.sh /init-start.sh
RUN chmod +x /init-start.sh
# Default command
ENTRYPOINT ["/init-start.sh"]
