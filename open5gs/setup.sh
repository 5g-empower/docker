#!/bin/bash

echo "1" > /proc/sys/net/ipv4/ip_forward
sysctl net.ipv6.conf.all.disable_ipv6=0

if ! grep "ogstun" /proc/net/dev > /dev/null; then
    ip tuntap add name ogstun mode tun
fi

ip addr del 10.45.0.1/16 dev ogstun 2> /dev/null
ip addr add 10.45.0.1/16 dev ogstun
ip addr del cafe::1/64 dev ogstun 2> /dev/null
ip addr add cafe::1/64 dev ogstun
ip link set ogstun up

iptables -I INPUT -i ogstun -j ACCEPT
iptables -A FORWARD -o ogstun -j ACCEPT
iptables -A FORWARD -s 10.45.0.1/16 -o `ip route get 1 | awk '{print $(NF-4);exit}'` -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.45.0.1/16 -o `ip route get 1 | awk '{print $(NF-4);exit}'` -j MASQUERADE
