FROM koenkk/zigbee2mqtt:1.16.1

ARG USERNAME
ARG PASSWORD

ENV USERNAME ${USERNAME}
ENV PASSWORD ${PASSWORD}

COPY configuration.yaml /app/data/configuration.yaml
COPY configuration.yaml /app/configuration.yaml

RUN sed 's/${USERNAME}/${USERNAME}/g' configuration.yaml
RUN sed 's/${PASSWORD}/${PASSWORD}/g' configuration.yaml