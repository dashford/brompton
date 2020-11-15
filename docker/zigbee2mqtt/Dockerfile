FROM koenkk/zigbee2mqtt:1.16.1

ARG USERNAME
ARG PASSWORD

ENV USERNAME ${USERNAME}
ENV PASSWORD ${PASSWORD}

COPY configuration.yaml /app/data/configuration.yaml
COPY configuration.yaml /app/configuration.yaml

RUN sed 's/USERNAME/USERNAME/g' /app/data/configuration.yaml
RUN sed 's/PASSWORD/PASSWORD/g' /app/data/configuration.yaml
RUN sed 's/USERNAME/USERNAME/g' /app/configuration.yaml
RUN sed 's/PASSWORD/PASSWORD/g' /app/configuration.yaml