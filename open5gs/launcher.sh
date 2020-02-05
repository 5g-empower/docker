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

/usr/local/bin/open5gs-pcrfd -D
/usr/local/bin/open5gs-pgwd -D
/usr/local/bin/open5gs-sgwd -D
/usr/local/bin/open5gs-hssd -D
/usr/local/bin/open5gs-mmed

child=$!

wait "$child"

