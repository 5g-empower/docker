#!/bin/bash

sed -i 's/MCC_REPLACE/'$MCC'/g' /open5gs/install/etc/open5gs/mme.yaml
sed -i 's/MNC_REPLACE/'$MNC'/g' /open5gs/install/etc/open5gs/mme.yaml
sed -i 's/TAC_REPLACE/'$TAC'/g' /open5gs/install/etc/open5gs/mme.yaml
