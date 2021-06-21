# docker build -t snslab/srsenb .
# docker run --name=srsenb --privileged snslab/srsenb
FROM ubuntu:20.04

MAINTAINER Roberto Riggio <roberto.riggio@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Dependencies for the UHD driver for the USRP hardware
RUN apt-get update && \
    apt-get -yq install cmake git libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libuhd-dev iproute2

# Fetching empower-enb-agent
RUN git clone https://github.com/5g-empower/empower-enb-agent.git
RUN cd empower-enb-agent && \
    cmake -DCMAKE_BUILD_TYPE=Release . && \
    make && \
    make install

# Fetching srsRAN
RUN git clone https://github.com/5g-empower/srsRAN.git && \
    cd srsRAN && \
    git checkout agent && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make

RUN ./usr/lib/uhd/utils/uhd_images_downloader.py

# Add configuration files from SRS
ADD conf/enb.conf /etc/srsran/
ADD conf/drb.conf /etc/srsran/
ADD conf/rr.conf /etc/srsran/
ADD conf/sib.conf /etc/srsran/

# Add Kubernetes launch scripts
ADD dns_replace.sh /

# Set env variables
ENV enb_id=0x19B

# Add launcher script
ADD launcher.sh /

# Run the launcher script
ENTRYPOINT ["/launcher.sh"]
