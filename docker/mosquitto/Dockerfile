FROM resin/rpi-raspbian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV MOSQUITTO_VERSION 1.4.9

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget \
    build-essential \
    libwrap0-dev \
    libssl-dev \
    python-distutils-extra \
    libc-ares-dev \
    uuid-dev

RUN mkdir -p /usr/local/src
RUN cd /usr/local/src && \
    wget http://mosquitto.org/files/source/mosquitto-${MOSQUITTO_VERSION}.tar.gz && \
    tar xvzf ./mosquitto-${MOSQUITTO_VERSION}.tar.gz && \
    cd /usr/local/src/mosquitto-${MOSQUITTO_VERSION} && \
    make && make install && \
    cd /usr/local/src && \

RUN rm mosquitto-${MOSQUITTO_VERSION}.tar.gz && \
    apt-get autoremove -y wget \
    build-essential \
    libwrap0-dev \
    libssl-dev \
    python-distutils-extra \
    libc-ares-dev \
    uuid-dev

RUN adduser --system --disabled-password --disabled-login mosquitto

EXPOSE 1883

CMD ["/usr/local/sbin/mosquitto"]
