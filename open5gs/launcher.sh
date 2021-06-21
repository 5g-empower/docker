#!/bin/sh

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child"
}

trap _term TERM

echo -e "\n\n---------- ENV VARIABLES ----------"
env

until nc -z localhost 27017
do
    echo "waiting for mongodb to come up..."
    sleep 2
done

sleep 10

/setup.sh

/usr/local/bin/open5gs-mmed -D
/usr/local/bin/open5gs-sgwcd -D
/usr/local/bin/open5gs-smfd -D
/usr/local/bin/open5gs-amfd -D
/usr/local/bin/open5gs-sgwud -D
/usr/local/bin/open5gs-upfd -D
/usr/local/bin/open5gs-hssd -D
/usr/local/bin/open5gs-pcrfd -D
/usr/local/bin/open5gs-nrfd -D
/usr/local/bin/open5gs-ausfd -D
/usr/local/bin/open5gs-udmd -D
/usr/local/bin/open5gs-pcfd -D
/usr/local/bin/open5gs-nssfd -D
/usr/local/bin/open5gs-bsfd -D
/usr/local/bin/open5gs-udrd
