## build : docker build -t empower-runtime .
## run :   docker run --net=host --rm --privileged -it empower-runtime

FROM ubuntu:19.10
MAINTAINER Roberto Riggio <rriggio@fbk.eu>

# Installing python dependencies
RUN buildDeps='python3-pip wget unzip' \
    && set -x \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install tornado==6.0.3 \
    && pip3 install construct==2.9.45 \
    && pip3 install pymodm==0.4.1 \
    && pip3 install influxdb==5.2.3 \
    && wget https://github.com/5g-empower/empower-runtime/archive/master.zip \
    && unzip master.zip \
    && rm master.zip \
    && ln -sf /empower-runtime-master/conf/ /etc/empower \
    && mkdir -p /var/www/ \
    && ln -s /empower-runtime-master/webui/ /var/www/empower \
    && apt-get purge -y --auto-remove $buildDeps

# Run the controller
ENTRYPOINT ["python3.7", "/empower-runtime-master/empower-runtime.py"]

# Expose Web GUI
EXPOSE 8888

# Expose LVAPP Server
EXPOSE 4433

# Expose VBSP Server
EXPOSE 5533
