#!/bin/bash

. settings.conf

MODE=d #default is daemon

while getopts ":i" opt; do
    case $opt in
	i)
	    MODE=i
	    CMD=/bin/bash
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    ;;
    esac
done


[ ! -d logs ] && mkdir logs/
[ ! -f logs/home-assistant.log ] && touch logs/home-assistant.log

docker run \
       --mac-address="${MAC_ADDRESS}" \
       -${MODE}t \
       --privileged \
       -h homeassistant \
       -v ${PWD}/logs/home-assistant.log:/config/home-assistant.log \
       -v ${PWD}/logs/OZW_Log.txt:/config/OZW_Log.txt \
       -v /etc/localtime:/etc/localtime:ro \
       -v /dev/ttyACM0:/dev/ttyACM0 \
       services/homeassistant:latest ${CMD}
