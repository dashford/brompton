all : up

up : up-traefik up-mosquitto up-influxdbha up-grafana up-homeassistant up-zigbee2mqtt
stop : stop-traefik stop-mosquitto stop-influxdbha stop-grafana stop-homeassistant stop-zigbee2mqtt
down : down-all


up-traefik :
	docker-compose up -d traefik

up-homeassistant :
	docker-compose up -d homeassistant

up-mosquitto :
	docker-compose up -d mosquitto

up-influxdbha :
	docker-compose up -d influxdbha

up-grafana :
	docker-compose up -d grafana

up-zigbee2mqtt :
	docker-compose up -d zigbee2mqtt


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


down-all :
	docker-compose down --remove-orphans