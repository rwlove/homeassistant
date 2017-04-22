FROM homeassistant/home-assistant

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
apt-get -y dist-upgrade && \
apt-get -y install apt-utils && \
dpkg --configure -a

RUN apt-get -y install isc-dhcp-client

RUN mv /sbin/dhclient /usr/sbin/dhclient
COPY scripts/fix_network_and_start.sh /usr/bin/fix_network_and_start.sh
RUN ln -s /usr/bin/fix_network_and_start.sh /usr/local/bin/runHomeassistant.sh

RUN easy_install --upgrade pytz
RUN pip install --upgrade pip
RUN pip3 install homeassistant
#RUN install --upgrade homeassistant

EXPOSE 8123

#####
# Clean up
#####

ADD options.xml /usr/src/app/build/python-openzwave/openzwave/config/options.xml

# Workaround for bug: https://community.home-assistant.io/t/0-36-docker-zwave-component-cant-find-zwcfg-xsd-anymore/9754
RUN ln -s /config/zwcfg.xsd /usr/src/app/build/python-openzwave/openzwave/config/zwcfg.xsd

RUN apt-get -y clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/*

CMD ["/usr/local/bin/runHomeassistant.sh"]

ADD config_files.tar.gz /config