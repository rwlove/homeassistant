#!/bin/bash

. settings.conf

echo -n "New build: v${HASS_VERSION}" | tee -a build.log
date | tee -a build.log

pushd config_files/custom_components/
CURR_DIR=${PWD}

rm -rf sonoff
mkdir /tmp/ewelink && pushd /tmp/ewelink
git clone https://github.com/peterbuga/HASS-sonoff-ewelink
mv HASS-sonoff-ewelink/sonoff ${CURR_DIR}/
popd && rm -rf /tmp/ewelink

popd

./helper_scripts/create_config_tarball.sh | tee -a build.log

docker build $* -t services/homeassistant:v${HASS_VERSION} . 2>&1 | tee -a build.log

#rm config_files.tar.gz

docker run --rm -it --entrypoint "/usr/local/bin/python" services/homeassistant:v${HASS_VERSION} -m homeassistant --script check_config --config /config 2>&1 | tee -a build.log
