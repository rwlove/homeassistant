#!/bin/bash

#       --net=host \
#       -p 8123:8123 \

docker run \
       --mac-address="92:20:DE:B0:6B:81" \
       -dt \
       --privileged \
       -h homeassistant \
       -v /root/docker_build/homeassistant/config:/config \
       -v /etc/localtime:/etc/localtime:ro \
       -v /dev/ttyACM0:/dev/ttyACM0 \
       -v /root/docker_build/homeassistant/options.xml:/usr/local/lib/python3.5/site-packages/libopenzwave-0.3.1-py3.5-linux-x86_64.egg/config/options.xml \
       -v /root/docker_build/homeassistant/options.xml:/usr/src/app/build/python-openzwave/openzwave/config/options.xml \
       services/homeassistant
