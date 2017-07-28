# homeassistant

The project is a packaging of the wonderful Home Assistant project (https://home-assistant.io).

** Prerequisite **

Copy the add_container_to_network.sh script, from https://github.com/rwlove/scripts.git, to somewhere in your PATH.
For example:
  git clone https://github.com/rwlove/scripts.git ; sudo cp scripts/add_container_to_network.sh /usr/local/bin/

*** container networking disclaimer ***
I prefer to treat my containers like hosts on my home network, as if they were VMs.

I configure a MAC address for each contaiener and when I run the container I use my add_container_to_network.sh script to create vEth pairs, with which I add one to a routable Linux Bridge and the other to the container's network namespace.

My home network's DHCP server then assigns a statically defined IP to the MAC that I've chosen for the container.

My DNS server has entries to assign a hostname to the container using the assigned IP. Many of my containers have been configured to interact with other containers using this assigned hostname.

This could all easily be untangled by someone who wants a simpler, more traditional, container aproach.

** Dependent Containers **

Install and run an instance of my customized MQTT server 'mosca' (http://www.mosca.io/) and speach recognition application 'blather' (http://www.jezra.net/projects/blather).

https://github.com/rwlove/mosca.git

https://github.com/rwlove/blather.git

Ensure that there are running docker instances of these services.

** Work In Progress **

This is my personal Home Assisstant build and configuration. The Dockerfile has some ugly hacks so that I can use my local (not docker's) DHCP server. I hope to move to a newer version of Docker soon that might allow me to remove the need for running dhclient.

TODO
-Certs don't work, so cannot access webui outside of home network
-Light dimming on Phillips Hue doesn't work
-Don't allow livingroom nightlight (pink) to override the kitchen motion (white)
- mpd on lefteye and righteye (in containers)
- fireplace zwave
- fix scene selector for all rooms
- fix brightness slider for all rooms
- don't turn off bathroom lights if humidity is detected
- can I determine the state of my Samsung TVs even if they're not smart?
- PS4 wakeup
- power state of motion sensors and other batery operated devices in web ui
