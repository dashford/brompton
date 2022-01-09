all : up

up : up-wireguard up-mosquitto up-influxdbha up-grafana up-homeassistant up-zigbee2mqtt up-homeassistant_db
stop : stop-wireguard stop-mosquitto stop-influxdbha stop-grafana stop-homeassistant stop-zigbee2mqtt stop-homeassistant_db
down : down-all


up-wireguard :
	docker-compose up --build -d wireguard

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

up-homeassistant_db :
	docker-compose up -d homeassistant_db


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

stop-homeassistant_db :
	docker stop homeassistant_db


down-all :
	docker-compose down --remove-orphans