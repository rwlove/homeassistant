#!/bin/bash

. settings.conf

[ ! -d logs ] && mkdir logs/
[ ! -f logs/home-assistant.log ] && touch logs/home-assistant.log

docker run \
       --mac-address="${MAC_ADDRESS}" \
       -dt \
       --privileged \
       -h homeassistant \
       -v ${PWD}/logs/home-assistant.log:/config/home-assistant.log \
       -v /etc/localtime:/etc/localtime:ro \
       -v /dev/ttyACM0:/dev/ttyACM0 \
       services/homeassistant:latest
