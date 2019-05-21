FROM ubuntu:16.04

MAINTAINER "Tien Vo" <tienvv.it@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# run install git, curl 
RUN apt-get update && apt-get install -y curl mysql-server \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

ADD config/init-start.sh /init-start.sh
RUN chmod +x /init-start.sh
# Default command
ENTRYPOINT ["/init-start.sh"]
