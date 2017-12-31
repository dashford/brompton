FROM resin/rpi-raspbian:jessie

# Base layer
ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

RUN apt-get update && \
    apt-get install --no-install-recommends \
      autoconf \
      build-essential \
      checkinstall \
      libreadline-gplv2-dev \
      libncursesw5-dev \
      libssl-dev \
      libsqlite3-dev \
      tk-dev \
      libgdbm-dev \
      libc6-dev \
      libbz2-dev \
      wget \
#      python3-dev \
#      python3-pip \
#      python3-setuptools \
      libcups2-dev \
      libffi-dev \
      libpython-dev \
      libudev-dev \
      bluetooth \
      libbluetooth-dev \
      net-tools \
      nmap \
      iputils-ping \
      ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

RUN wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz && \
    tar xzf Python-3.6.4.tgz && \
    rm Python-3.6.4.tgz && \
    cd Python-3.6.4 && \
    bash configure && \
    make altinstall

COPY requirements.txt ./

# Mouting point for the user's configuration
VOLUME /config

# Start Home Assistant
#CMD [ "python3.6", "-m", "homeassistant", "--config", "/config" ]

# Install Home Assistant
#RUN pip3 install -r requirements.txt

EXPOSE 8123
