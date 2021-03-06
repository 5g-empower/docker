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

/empower-runtime-master/empower-runtime.py
