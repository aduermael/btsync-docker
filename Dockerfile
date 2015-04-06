FROM ubuntu:14.04
MAINTAINER Adrien Duermael (adrien@duermael.com)

ENV DEBIAN_FRONTEND noninteractive

########## BTSYNC ##########

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install curl -y
RUN apt-get install nodejs -y

RUN curl -o /usr/bin/btsync.tar.gz https://download-cdn.getsyncapp.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz
RUN cd /usr/bin; tar xvzf btsync.tar.gz; rm btsync.tar.gz;

ADD btsync /btsync
RUN mkdir /btsync/storage

EXPOSE 55555

WORKDIR /btsync

# Arguments: DIR SECRET
ENTRYPOINT ["/bin/bash", "./start.sh"]