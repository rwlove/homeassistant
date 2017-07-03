FROM homeassistant/home-assistant

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
apt-get -y dist-upgrade && \
apt-get -y install apt-utils \
libudev-dev && \
dpkg --configure -a

COPY scripts/runHomeassistant.sh /usr/bin/runHomeassistant.sh

RUN easy_install --upgrade pytz
RUN pip install --upgrade pip
RUN pip3 install homeassistant==0.48

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

CMD ["/usr/bin/runHomeassistant.sh"]

ADD config_files.tar.gz /config