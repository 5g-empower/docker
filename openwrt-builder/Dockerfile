## build : docker build -t 5gempower/openwrt-builder .

FROM ubuntu:18.04
MAINTAINER Giovanni Baggio <g.baggio@fbk.eu>

RUN apt-get update && \
    apt-get -y install build-essential libncurses5-dev unzip python2.7
RUN apt-get -y install git gawk wget

RUN useradd -ms /bin/bash build-user

ADD launcher.sh /

USER build-user
WORKDIR /home/newuser

# Run the launcher script
ENTRYPOINT ["/launcher.sh"]
