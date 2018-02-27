#!/bin/bash

. settings.conf

echo -n "New build: v${HASS_VERSION}" | tee -a build.log
date | tee -a build.log

./helper_scripts/create_config_tarball.sh | tee -a build.log

docker build $* -t services/homeassistant:v${HASS_VERSION} . 2>&1 | tee -a build.log

rm config_files.tar.gz

docker run --rm services/homeassistant:v${HASS_VERSION} python -m homeassistant --script check_config --config /config 2>&1 | tee -a build.log
