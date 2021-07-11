all : up

up : up-wireguard up-mosquitto up-influxdbha up-grafana up-homeassistant up-zigbee2mqtt
stop : stop-wireguard stop-mosquitto stop-influxdbha stop-grafana stop-homeassistant stop-zigbee2mqtt
down : down-all


up-wireguard :
	docker-compose up -d wireguard

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


stop-wireguard :
	docker stop wireguard

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


down-all :
	docker-compose down --remove-orphans