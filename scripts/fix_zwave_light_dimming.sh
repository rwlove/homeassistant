#!/bin/bash

mv ./homeassistant/components/light/zwave.py{,.in}
cat ./homeassistant/components/light/zwave.py.in | sed "s/self._timer = Timer(2, _refresh_value)/self._timer = Timer(3, _refresh_value)/g" > ./homeassistant/components/light/zwave.py
rm ./homeassistant/components/light/zwave.py.in
