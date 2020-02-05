#!/bin/sh

_term() { 
  echo "Caught SIGTERM signal!" 
  kill -TERM "$child"
}

trap _term SIGTERM

echo -e "\n\n---------- ENV VARIABLES ----------"
env


until nc -z localhost 27017
do
    echo "waiting for mongodb to come up..."
    sleep 2
done

sleep 5

npm run start

child=$!

wait "$child"

