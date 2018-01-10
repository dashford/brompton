FROM resin/rpi-raspbian:jessie

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/local/bin
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto

ENTRYPOINT ["/usr/local/bin/certbot-auto"]
CMD ["--help"]

#RUN apt-get update
