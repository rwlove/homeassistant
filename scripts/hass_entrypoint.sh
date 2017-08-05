#!/bin/bash

while ! ping -c 1 brain; do
    echo "(homeassistant) Waiting for brian - network interface might be down..."
    sleep 1
done

/usr/local/bin/hass --config /config
