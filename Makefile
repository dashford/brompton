all : up

up : up-traefik up-mosquitto up-influxdbha up-grafana up-homeassistant up-zigbee2mqtt up-pihole
stop : stop-traefik stop-mosquitto stop-influxdbha stop-grafana stop-homeassistant stop-zigbee2mqtt stop-pihole
down : down-all


up-traefik :
	docker-compose up -d traefik

up-homeassistant :
	docker-compose up -d homeassistant

up-mosquitto :
	docker-compose up -d mosquitto
	docker exec -d --env-file .env mosquitto mosquitto_passwd -c -b /mosquitto/config/passwd "${MQTT_USER}" "${MQTT_PASSWORD}"

up-influxdbha :
	docker-compose up -d influxdbha

up-grafana :
	docker-compose up -d grafana

up-zigbee2mqtt :
	docker-compose up -d zigbee2mqtt

up-pihole :
	docker-compose up -d pihole


stop-traefik :
	docker stop traefik

stop-homeassistant :
	docker stop homeassistant

stop-mosquitto :
	docker stop mosquitto

stop-influxdbha :
	docker stop influxdbha

stop-grafana :
	docker stop grafana

stop-zigbee2mqtt :
	docker stop zigbee2mqtt

stop-pihole :
	docker stop pihole


down-all :
	docker-compose down --remove-orphans