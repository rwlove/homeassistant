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
       -v /root/docker_build/homeassistant/options.xml:/usr/local/lib/python3.5/site-packages/libopenzwave-0.3.1-py3.5-linux-x86_64.egg/config/options.xml \
       -v /root/docker_build/homeassistant/options.xml:/usr/src/app/build/python-openzwave/openzwave/config/options.xml \
       services/homeassistant
