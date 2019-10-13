FROM homeassistant/raspberrypi2-homeassistant:0.100.1

WORKDIR /usr/src

# Mounting point for HA's instance files
VOLUME /ha-installation

# Start Home Assistant
ADD run.sh ./
RUN chmod +x run.sh
ENTRYPOINT [ "./run.sh" ]

EXPOSE 8123
