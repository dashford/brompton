FROM python:3.6-alpine3.7

RUN apk --update add --no-cache \
    gcc \
    linux-headers \
    musl-dev \
    shadow

RUN useradd -rm homeassitant

WORKDIR /usr/src/app

RUN mkdir homeassitant && \
    chown homeassitant:homeassitant homeassitant

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

USER homeassitant

ENTRYPOINT [ "hass" ]

CMD [ "--open-ui" ]

# TODO
# create configuration.yml and other yml files or share between volumes
