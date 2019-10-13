# home-assistant

## TODO

- mqtt: owntracks 883 listener config no longer working
- set up cron for restarting docker containers
- mqtt: set up acl_file
- mqtt: set up different users / client IDs with restrictions
- mqtt: username that phone connects with is the user taken by owntracks and displayed by homeassistant
- mqtt: add persistence file
- mqtt: add users and passwords as part of build step in ENV
- misc images: move to rpi-alpine base image
- nginx: go through ssl configuration (protocols and ciphers)
- nginx: add https 301 redirect
- homeassistant: remove requirements versions or handle proper updating between versions
- homeassistant: double check command start
- investigate automated deployment options (https://docs.gitlab.com/ee/topics/autodevops/)
- get application and node logs pushed into influxdb for grafana consumption
