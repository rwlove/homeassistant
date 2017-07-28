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

### TODO ###
* TBD

### Wishlist ###
* Certs don't work, so cannot access webui outside of home network
* fireplace zwave
* PS4 wakeup
* power state of motion sensors and other batery operated devices in web ui
