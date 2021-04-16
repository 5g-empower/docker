#!/bin/sh

if [ "$k8s_dns" = "yes" ]; then
    echo "Setting the k8s dns server in open5gs"
    sed -i 's/PRIMARY_DNS_REPLACE/'$(cat /etc/resolv.conf | grep nameserver | awk '{print $NF}')'/g' /usr/local/etc/open5gs/pgw.yaml
else
    echo "Setting the default dns server in nextepc"
    sed -i 's/PRIMARY_DNS_REPLACE/'"8.8.8.8"'/g' /usr/local/etc/open5gs/pgw.yaml
fi

echo "1" > /proc/sys/net/ipv4/ip_forward

if ! grep "pgwtun1010" /proc/net/dev > /dev/null; then
    ip tuntap add name pgwtun1010 mode tun
    ip addr add 10.10.0.1/16 dev pgwtun1010
    ip link set pgwtun1010 up
    
    iptables -I INPUT -i pgwtun1010 -j ACCEPT
    iptables -A FORWARD -o pgwtun1010 -j ACCEPT
    iptables -A FORWARD -s 10.10.0.0/16 -o eno1 -j ACCEPT
    iptables -t nat -A POSTROUTING -s 10.10.0.0/16 -o `ip route get 1 | awk '{print $(NF-4);exit}'` -j MASQUERADE
fi

if ! grep "pgwtun1020" /proc/net/dev > /dev/null; then
    ip tuntap add name pgwtun1020 mode tun
    ip addr add 10.20.0.1/16 dev pgwtun1020
    ip link set pgwtun1020 up
    
    iptables -I INPUT -i pgwtun1020 -j ACCEPT
    iptables -A FORWARD -o pgwtun1020 -j ACCEPT
    iptables -A FORWARD -s 10.20.0.0/16 -o eno1 -j ACCEPT
    iptables -t nat -A POSTROUTING -s 10.20.0.0/16 -o `ip route get 1 | awk '{print $(NF-4);exit}'` -j MASQUERADE
fi
