#!/bin/bash

. settings.conf

MODE=d #default is daemon
ZWAVE_DEV=""

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

for f in $( ls /dev/ttyAC* ) ; do
    echo "Testing file: $f"
    if [ -c "${f}" ] ; then
	ZWAVE_DEV="${f}"
	echo "  - VALID Z-Wave Device"
    else
	echo "  - invalid Z-Wave Device"
    fi
done

[ ! -d logs ] && mkdir logs/
[ ! -f logs/home-assistant.log ] && touch logs/home-assistant.log

if [ "" == "${ZWAVE_DEV}" ] ; then
    echo "Exiting, no Z-Wave device found"
    echo "Exiting, no Z-Wave device found" >> ${PWD}/logs/home-assistant.log
    exit -1
fi  

docker run \
       --network="none" \
       -${MODE}t \
       --privileged \
       -h homeassistant \
       -v ${PWD}/logs/home-assistant.log:/config/home-assistant.log \
       -v ${PWD}/logs/OZW_Log.txt:/config/OZW_Log.txt \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${ZWAVE_DEV}:/dev/ttyACM0 \
       services/homeassistant:v0.52.1 ${CMD}

add_contianer_to_network.sh -n homeassistant -b br0 -m ${MAC_ADDRESS} -v "hass"
