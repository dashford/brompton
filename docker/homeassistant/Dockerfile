FROM resin/rpi-raspbian:jessie

# Base layer
ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

RUN apt-get update && \
    apt-get install --no-install-recommends \
      autoconf \
      build-essential python3-dev python3-pip python3-setuptools \
      libcups2-dev \
      libffi-dev libpython-dev libssl-dev \
      libudev-dev \
      bluetooth libbluetooth-dev \
      net-tools nmap \
      iputils-ping \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Mouting point for the user's configuration
VOLUME /config

# Start Home Assistant
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]

# Install Home Assistant
RUN pip3 install wheel
RUN pip3 install sqlalchemy==1.1.15
RUN pip3 install user-agents==1.1.0
RUN pip3 install aiohttp_cors==0.5.3
RUN pip3 install home-assistant-frontend==20171216.0
RUN pip3 install homeassistant==0.60
