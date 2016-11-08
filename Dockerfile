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

COPY certs/server.key /server.key
COPY certs/server.cert /server.cert

COPY certs/new/privkey.pem /privkey.pem
COPY certs/new/fullchain.pem /fullchain.pem

RUN pip3 install homeassistant==0.30.2

ADD config_files.tar.gz /config

EXPOSE 8123

#####
# Clean up
#####

RUN apt-get -y clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/*

CMD ["/usr/local/bin/runHomeassistant.sh"]