FROM ubuntu:14.04
MAINTAINER Adrien Duermael (adrien@duermael.com)

ENV DEBIAN_FRONTEND noninteractive

########## BTSYNC ##########

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install curl -y
RUN apt-get install nodejs -y

RUN curl -o /usr/bin/btsync.tar http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
RUN cd /usr/bin; tar xvf btsync.tar; rm btsync.tar; rm LICENSE.TXT

ADD btsync /btsync

EXPOSE 55555

WORKDIR /btsync

# Arguments: DIR SECRET
ENTRYPOINT ["/bin/bash", "./start.sh"]