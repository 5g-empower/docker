#!/bin/sh

if ! grep "ogstun" /proc/net/dev > /dev/null; then
    ip tuntap add name ogstun mode tun
fi

if test "x`sysctl -n net.ipv6.conf.ogstun.disable_ipv6`" = x1; then
    echo "net.ipv6.conf.ogstun.disable_ipv6=0" > /etc/sysctl.d/30-open5gs.conf
    sysctl -p /etc/sysctl.d/30-open5gs.conf
fi

ip addr del 10.45.0.1/16 dev ogstun 2> /dev/null
ip addr add 10.45.0.1/16 dev ogstun
ip addr del cafe::1/64 dev ogstun 2> /dev/null
ip addr add cafe::1/64 dev ogstun
ip link set ogstun up
