FROM resin/rpi-raspbian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --force-yes certbot -t jessie-backports
