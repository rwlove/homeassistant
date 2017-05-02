#!/bin/bash

IFNAME=eth0

ip addr flush dev ${IFNAME}

/usr/sbin/dhclient -v ${IFNAME}

sleep 1

/usr/local/bin/hass --config /config
