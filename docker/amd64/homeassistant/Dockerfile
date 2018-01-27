FROM debian:jessie

# Base layer
ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      autoconf \
      build-essential \
      ca-certificates \
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

RUN wget --no-check-certificate https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz && \
    tar xzf Python-3.6.4.tgz && \
    rm Python-3.6.4.tgz && \
    cd Python-3.6.4 && \
    bash configure && \
    make altinstall

# Install Home Assistant
ADD requirements.txt ./
RUN pip3.6 install -r requirements.txt

# Mounting point for HA's instance files
VOLUME /ha-installation

# Mouting point for the user's configuration
VOLUME /config

# Start Home Assistant
ADD run.sh ./
RUN chmod +x run.sh
ENTRYPOINT [ "./run.sh" ]

EXPOSE 8123
