FROM homeassistant/raspberrypi2-homeassistant:0.83.3

WORKDIR /usr/src

# Mounting point for HA's instance files
VOLUME /ha-installation

# Start Home Assistant
ADD run.sh ./
RUN chmod +x run.sh
ENTRYPOINT [ "./run.sh" ]

EXPOSE 8123
