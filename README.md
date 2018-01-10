# homeassistant #

The project is a packaging of the wonderful [Home Assistant](https://home-assistant.io) project .

## Container Networking Disclaimer ##
I prefer to treat my containers like hosts on my home network, as if they were VMs.

I configure a MAC address for each contaiener and when I run the container I use my add_container_to_network.sh script to create vEth pairs, with which I add one to a routable Linux Bridge and the other to the container's network namespace.

My home network's DHCP server then assigns a statically defined IP to the MAC that I've chosen for the container.

My DNS server has entries to assign a hostname to the container using the assigned IP. Many of my containers have been configured to interact with other containers using this assigned hostname.

This could all easily be untangled by someone who wants a simpler, more traditional, container aproach.

## Prerequisites ##

Copy the add_container_to_network.sh script, from my [scripts](https://github.com/rwlove/scripts) repository, to somewhere in your PATH.

For example:

`git clone https://github.com/rwlove/scripts.git`

`sudo cp scripts/add_container_to_network.sh /usr/local/bin/`

## Dependent Containers ##
Install and run an instance of my customized MQTT server 'mosca' [Mosca](http://www.mosca.io/) and speach recognition application 'blather' [Blather](http://www.jezra.net/projects/blather).

https://github.com/rwlove/mosca.git

https://github.com/rwlove/blather.git

Ensure that there are running docker instances of these services.

### Supported Hardware ###
* Z-Wave
  * Aeotec By Aeon Labs Gen5 Z-wave Plus 6-in-1 Multisensor 6 ZW100-A
  * Ecolink Intelligent Technology Z-Wave Easy Install, Battery Operated, Door/Window Sensor, White & Brown (DWZWAVE2-ECO)
  * GE Z-Wave Wireless Lighting Control Smart Dimmer Toggle Switch, In-Wall, White, 12729
  * GE Z-Wave Wireless Lighting Control Smart Toggle Switch, In-Wall, White, 12727
  * Aeon Labs Aeotec Z-Wave Z-Stick, Gen5 (ZW090)
  * Ideal Security Inc. SK630 Pressure Mat Alarm with Chime
* Philips Hue
  * Philips Hue LightStrip Plus Dimmable LED Smart Light (Compatible with Amazon Alexa, Apple HomeKit, and Google Assistant)
  * Philips Hue LightStrip Plus Dimmable LED Smart Light Extension (Compatible with Amazon Alexa, Apple HomeKit, and Google Assistant)
  * Philips 464503 Hue White and Color A19 LED Bulb, 3rd Generation with Richer Colors, Works with Amazon Alexa
  * Philips Hue Lightstrip Plus, 2nd Generation, Works with Amazon Alexa
  * Philips 800284 Hue Lightstrip Plus, 2nd Generation
  * Philips 464503 Hue White and Color A19 LED Bulb, 3rd Generation
  * Philips 431650 Hue Personal Wireless Lighting, A19 Single Bulb, Frustration Free
  * Philips 431643 Hue Personal Wireless Lighting, Starter Pack, Frustration Free
* Appliances
  * Dyson Pure Cool Link Air Purifier, White
  * Roomba (Details TBD)
  * Onkyo TX-NR656 7.2 Channel Network A/V Receiver
  * Nest Learning Thermostat - 2nd Generation T200577
* Peripherals
  * Movo MC1000 USB Desktop Conference Computer Microphone with 180° / 20' Pickup Range for Windows & Mac - Plug & Play
  
### Not-Yet-Working/Installed Hardware ###
* Remotec Zwave Dry Contact Fixture Module

### TODO ###
* TBD

### Wishlist ###
* Certs don't work, so cannot access webui outside of home network
* fireplace zwave
* PS4 wakeup
* power state of motion sensors and other batery operated devices in web ui
