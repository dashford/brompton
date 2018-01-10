FROM resin/rpi-raspbian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install wget

WORKDIR /usr/local/bin
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto

ENTRYPOINT ["/usr/local/bin/certbot-auto"]
CMD [
    "certonly",
    "--standalone",
    "--preferred-challenges http-01",
    "--email david@dashford.io",
    "-d pandora.dashford.io"
]
