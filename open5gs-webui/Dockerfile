# docker build -t snslab/open5gs-webui .
# docker run -d --name=open5gs-webui snslab/open5gs-webui
FROM node:carbon

MAINTAINER Sukchan Lee <acetcom@gmail.com>

ARG PACKAGE=open5gs
ARG VERSION=2.3.0

RUN set -e; \
    cd /usr/src; \
    rm -rf ./$PACKAGE; \
    curl -SLO "https://github.com/open5gs/$PACKAGE/archive/v$VERSION.tar.gz"; \
    tar -xvf v$VERSION.tar.gz; \
    mv ./$PACKAGE-$VERSION/ ./$PACKAGE;

WORKDIR /usr/src/open5gs/webui
RUN npm install && \
    npm run build

CMD npm run dev

EXPOSE 3000
