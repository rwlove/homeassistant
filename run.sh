#!/bin/bash

. settings.conf

MODE=d #default is daemon
ZWAVE_DEV="/dev/zwave"
WYZE_DEV="/dev/wyzesense"

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

if [ "" == "${ZWAVE_DEV}" ] ; then
    echo "Exiting, no Z-Wave device found"
    echo "Exiting, no Z-Wave device found" >> ${PWD}/logs/home-assistant.log
    exit -1
fi

if [ "" == "${WYZE_DEV}" ] ; then
    echo "Exiting, no Wyze Bridge (${WYZE_DEV}) found"
    echo "Exiting, no Wize Bridge (${WYZE_DEV}) found" >> ${PWD}/logs/home-assistant.log
    exit -1
fi  

echo "Creating Container"

docker run \
       --network="none" \
       -${MODE}t \
       --privileged \
       -h homeassistant \
       -v ${PWD}/logs/home-assistant.log:/config/home-assistant.log \
       -v ${PWD}/logs/OZW_Log.txt:/config/OZW_Log.txt \
       -v ${PWD}/persistent:/config/.storage \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${ZWAVE_DEV}:/dev/zwave \
       -v ${WYZE_DEV}:/dev/wyze \
       -v /dev/wyzesense:/dev/wyzesense: \
       services/homeassistant:v${HASS_VERSION} ${CMD}

add_contianer_to_network.sh -n homeassistant -b br0 -m ${MAC_ADDRESS} -v "hass"
