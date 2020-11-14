FROM koenkk/zigbee2mqtt:1.16.1

RUN apk add gettext

RUN envsubst < /app/data/configuration.yaml | tee /app/data/configuration.yaml