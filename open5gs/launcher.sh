#!/bin/bash

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child"
}

trap _term TERM

echo "\n\n---------- ENV VARIABLES ----------"
env

until nc -z localhost 27017
do
    echo "waiting for mongodb to come up..."
    sleep 10
done

sleep 10

/dns_replace.sh
/setup.sh

/open5gs/install/bin/open5gs-mmed -D
/open5gs/install/bin/open5gs-sgwcd -D
/open5gs/install/bin/open5gs-smfd -D
/open5gs/install/bin/open5gs-amfd -D
/open5gs/install/bin/open5gs-sgwud -D
/open5gs/install/bin/open5gs-upfd -D
/open5gs/install/bin/open5gs-hssd -D
/open5gs/install/bin/open5gs-pcrfd -D
/open5gs/install/bin/open5gs-nrfd -D
/open5gs/install/bin/open5gs-ausfd -D
/open5gs/install/bin/open5gs-udmd -D
/open5gs/install/bin/open5gs-pcfd -D
/open5gs/install/bin/open5gs-nssfd -D
/open5gs/install/bin/open5gs-bsfd -D
/open5gs/install/bin/open5gs-udrd
