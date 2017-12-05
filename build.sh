#!/bin/bash

BUILD_VER="v0.59.1"

echo -n "New build: ${BUILD_VER}" | tee -a build.log
date | tee -a build.log

./helper_scripts/create_config_tarball.sh | tee -a build.log

docker build $* -t services/homeassistant:${BUILD_VER} . 2>&1 | tee -a build.log

rm config_files.tar.gz

docker run --rm services/homeassistant:${BUILD_VER} python -m homeassistant --script check_config --config /config 2>&1 | tee -a build.log
