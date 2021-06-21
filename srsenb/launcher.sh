#!/bin/bash

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child"
}

trap _term SIGTERM

env

./dns_replace.sh
./srsRAN/build/srsenb/src/srsenb &

child=$!

wait "$child"
