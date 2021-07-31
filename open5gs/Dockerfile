# docker build -t snslab/open5gs .
# docker run -d --name=open5gs --privileged snslab/open5gs
FROM ubuntu:20.04

MAINTAINER Roberto Riggio <roberto.riggio@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

USER root

# Dependencies for the Open5gs
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
        iputils-ping \
        nano \
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
        iptables

# Fetching Open5gs
RUN git clone https://github.com/open5gs/open5gs && cd /open5gs && meson build --prefix=`pwd`/install && ninja -C build

RUN cd /open5gs/build && ninja install

# Coping configuration files needed
COPY conf/* /open5gs/install/etc/open5gs/

# Solve the shared libraries problem
RUN sh -c "echo /open5gs/install/lib/x86_64-linux-gnu > /etc/ld.so.conf.d/open5gs.conf"
RUN ldconfig

# Set env variables
ENV MCC=001
ENV MNC=01
ENV TAC=7

# Add Kubernetes config, setup and launch scripts
ADD setup.sh /
ADD launcher.sh /
ADD dns_replace.sh /

# Run the launcher script
ENTRYPOINT ["/launcher.sh"]
