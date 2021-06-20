# docker build -t snslab/empower-runtime .
# docker run -d snslab/empower-runtime
FROM ubuntu:20.04

MAINTAINER Roberto Riggio <roberto.riggio@gmail.com>

# Installing python dependencies
RUN buildDeps='python3-pip wget unzip' \
    && set -x \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && apt-get install -y python3 \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install empower-core==1.0.7 \
    && pip3 install tornado==6.1 \
    && pip3 install construct==2.10.56 \
    && pip3 install pymodm==0.4.3 \
    && pip3 install influxdb==5.3.0 \
    && pip3 install python-stdnum==1.13 \
    && pip3 install requests==2.23.0 \
    && wget https://github.com/5g-empower/empower-runtime/archive/master.zip \
    && unzip master.zip \
    && rm master.zip \
    && ln -sf /empower-runtime-master/conf/ /etc/empower \
    && mkdir -p /var/www/ \
    && ln -s /empower-runtime-master/webui/ /var/www/empower
    #&& apt-get purge -y --auto-remove $buildDeps

# Add configuration files
ADD conf/runtime.cfg /etc/empower/

# Run the launcher
ADD launcher.sh /

# Define the entrypoint
ENTRYPOINT ["/launcher.sh"]

# Expose Web GUI
EXPOSE 8888

# Expose LVAPP Server
EXPOSE 4433

# Expose VBSP Server
EXPOSE 5533
