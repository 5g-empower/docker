FROM ubuntu:18.04

MAINTAINER Giovanni Baggio <g.baggio@fbk.eu>

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
        iproute2 \
        ca-certificates \
        netbase \
        netcat \
        iptables \
        pkg-config && \
    apt-get clean
RUN python3 -m pip install meson

WORKDIR /root

ARG USER=open5gs
ARG REPO=open5gs
ARG BRANCH=master
RUN	git clone https://github.com/$USER/$REPO
ADD https://api.github.com/repos/$USER/$REPO/git/refs/heads/$BRANCH /root/open5gs-ver.json

RUN	cd $REPO && \
	git fetch && git checkout -f -B $BRANCH origin/$BRANCH && \
    meson build && ninja -C build install


COPY conf/* /usr/local/etc/open5gs/
ADD setup.sh /
ADD launcher.sh /

ENV k8s_dns=no

ENTRYPOINT ["/launcher.sh"]

