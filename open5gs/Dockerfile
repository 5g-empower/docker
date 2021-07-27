# docker build -t snslab/open5gs .
# docker run -d --name=open5gs --privileged snslab/open5gs
FROM ubuntu:20.04

MAINTAINER Roberto Riggio <roberto.riggio@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ARG TAG=2.3.2

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        ninja-build \
        build-essential \
        flex \
        bison \
        git \
        libsctp-dev \
        libgnutls28-dev \
        libgcrypt-dev \
        libssl-dev \
        libidn11-dev \
        libmongoc-dev \
        libbson-dev \
        libyaml-dev \
        libnghttp2-dev \
        libmicrohttpd-dev \
        libcurl4-gnutls-dev \
        meson \
        netcat \
        iproute2 \
        wget \
        unzip \
        iptables && \
    wget https://github.com/open5gs/open5gs/archive/v$TAG.zip && \
    unzip v$TAG.zip && \
    rm v$TAG.zip && \
    cd open5gs-$TAG && \
    meson build && \
    ninja -C build install

COPY conf/* /usr/local/etc/open5gs/

ADD setup.sh /
ADD launcher.sh /

ENTRYPOINT ["/launcher.sh"]
