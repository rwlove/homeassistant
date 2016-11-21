# homeassistant

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