#!/bin/bash

echo -n "New build: " | tee -a build.log
date | tee -a build.log

./helper_scripts/create_config_tarball.sh | tee -a build.log

docker build $* -t services/homeassistant:v0.55 . 2>&1 | tee -a build.log

rm config_files.tar.gz

docker run --rm services/homeassistant:latest hass --script check_config --config /config 2>&1 | tee -a build.log
