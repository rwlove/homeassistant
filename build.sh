#!/bin/bash

./helper_scripts/create_config_tarball.sh

docker build -t services/homeassistant .

rm config_files.tar.gz

docker run --rm services/homeassistant:latest hass --script check_config --config /config
