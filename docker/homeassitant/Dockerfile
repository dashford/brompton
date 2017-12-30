FROM python:3.6-alpine3.7

RUN apk --update add --no-cache \
    gcc \
    linux-headers \
    musl-dev \
    shadow

RUN useradd -rm homeassistant

WORKDIR /usr/src/app

RUN mkdir homeassistant && \
    chown homeassistant:homeassistant homeassistant

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

USER homeassistant

EXPOSE 8123

VOLUME ["/home/homeassistant/.homeassistant"]

ENTRYPOINT [ "hass" ]

CMD [ "--open-ui" ]

# TODO
# create configuration.yml and other yml files or share between volumes
