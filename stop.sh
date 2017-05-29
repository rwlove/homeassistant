#!/bin/bash

docker stop `docker ps | grep services/homeassistant | cut -d ' ' -f 1`

ip link delete hass-ext
