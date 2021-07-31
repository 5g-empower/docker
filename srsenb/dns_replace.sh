#!/bin/bash

if [ -z "$empower_pod_addr" ]; then

    while [ -z $(getent hosts runtime-service | awk '{ print $1 }') ]
    do
        echo "Waiting for the 5G-EmPOWER Runtime to come up..."
        sleep 10
    done

    sleep 10

    EMPOWER_POR_ADDR=$(getent hosts empower-service | awk '{ print $1 }')
    echo "5G-EmPOWER Runtime service found: $EMPOWER_POR_ADDR"

else

    EMPOWER_POR_ADDR=$empower_pod_addr

fi

if [ -z "$epc_pod_addr" ]; then

    EPC_POD_ADDR=$(getent hosts epc-service | awk '{ print $1 }')

    while [ -z "$EPC_POD_ADDR" ]
    do
        echo "Waiting for the EPC to come up..."
        sleep 10
        EPC_POD_ADDR=$(getent hosts epc-service | awk '{ print $1 }')
    done

    echo "EPC service found: $EPC_POD_ADDR"

else
    EPC_POD_ADDR=$epc_pod_addr
fi

if [ -z "$local_pod_addr" ]; then
    LOCAL_POD_ADDR=$(ip route get 1 | awk '{print $(NF-2);exit}')
    echo "Local POD Addr: $LOCAL_POD_ADDR"
else
    LOCAL_POD_ADDR=$local_pod_addr
fi

sed -i 's/ENB_ID_REPLACE/'$enb_id'/g' /etc/srsran/enb.conf
sed -i 's/MCC_REPLACE/'$mcc'/g' /etc/srsran/enb.conf
sed -i 's/MNC_REPLACE/'$mnc'/g' /etc/srsran/enb.conf
sed -i 's/N_PRB_REPLACE/'$n_prb'/g' /etc/srsran/enb.conf
sed -i 's/EPC_REPLACE/'"$EPC_POD_ADDR"'/g' /etc/srsran/enb.conf
sed -i 's/LOCAL_REPLACE/'$LOCAL_POD_ADDR'/g' /etc/srsran/enb.conf
sed -i 's/EMPOWER_REPLACE/'$EMPOWER_POR_ADDR'/g' /etc/srsran/enb.conf
