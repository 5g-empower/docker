## build : docker build -t srsenb .
## run :   docker run --net=host --rm --privileged -it srsenb

FROM ubuntu:19.10
MAINTAINER Giovanni Baggio <g.baggio@fbk.eu>
ENV DEBIAN_FRONTEND noninteractive

# Dependencies for the UHD driver for the USRP hardware
RUN apt-get update && \
    apt-get -yq install cmake git libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libuhd-dev

# Fetching srsLTE
RUN git clone https://github.com/5g-empower/srsLTE.git && cd /srsLTE && git checkout tags/release_19_09
ADD conf/CMakeLists.txt /srsLTE/
RUN cd /srsLTE && mkdir build && cd build && cmake ../ && make && make install
RUN ./usr/lib/uhd/utils/uhd_images_downloader.py

# Add configuration files from SRS
ADD conf/enb.conf /etc/srslte/
ADD conf/drb.conf /etc/srslte/
ADD conf/rr.conf /etc/srslte/
ADD conf/sib.conf /etc/srslte/
ADD conf/sib.conf.mbsfn /etc/srslte/

# Add Kubernetes launch scripts
ADD dns_replace.sh /

# Set env variables
ENV empower_controller=no
ENV enb_id=0x19B
ENV cell_id=0x03
ENV phy_cell_id=3
ENV tac=0x0001
ENV mcc=222
ENV mnc=93
ENV n_prb=25
ENV dl_earfcn=3400

RUN apt-get -yq install iproute2

ADD launcher.sh /

# Run the launcher script
ENTRYPOINT ["/launcher.sh"]
