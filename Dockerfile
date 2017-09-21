FROM homeassistant/home-assistant:0.53.1

#####
# Set Environment Variables.
#################################

ENV DEBIAN_FRONTEND=noninteractive


#####
# Install Software.
#################################

RUN apt-get -y update && \
apt-get -y dist-upgrade && \
apt-get -y install apt-utils \
libudev-dev \
inetutils-ping \
iproute2 && \
dpkg --configure -a


#####
# Copy in scripts and config files.
#################################

COPY scripts/hass_entrypoint.sh /hass_entrypoint.sh
ADD options.xml /usr/src/app/build/python-openzwave/openzwave/config/options.xml


#####
# Workarounds and Issues.
#################################

# Workaround for bug: https://community.home-assistant.io/t/0-36-docker-zwave-component-cant-find-zwcfg-xsd-anymore/9754
RUN ln -s /config/zwcfg.xsd /usr/src/app/build/python-openzwave/openzwave/config/zwcfg.xsd


#####
# Open Port and Set the entrypoint.
#################################

EXPOSE 8123
CMD ["/hass_entrypoint.sh"]


#####
# Clean up.
#################################

RUN apt-get -y clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/*


#####
# Add in HASS configuration files. The tarball is generated by the build.sh script.
#################################

ADD config_files.tar.gz /config