# docker build -t snslab/openwrt-builder .
# docker run -d -v ~/src/builds:/home/build-user/builds snslab/openwrt-builder
FROM ubuntu:20.04

MAINTAINER Roberto Riggio <roberto.riggio@gmail.com>

RUN apt-get update && \
    apt-get -y install build-essential libncurses5-dev unzip python2.7
RUN apt-get -y install git gawk wget

RUN useradd -ms /bin/bash build-user

ADD launcher.sh /

USER build-user
WORKDIR /home/build-user

# Run the launcher script
ENTRYPOINT ["/launcher.sh"]
