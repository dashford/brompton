all : up

up : up-wireguard up-mosquitto up-influxdb up-grafana up-homeassistant up-zigbee2mqtt up-homeassistant_db
stop : stop-wireguard stop-mosquitto stop-influxdb stop-grafana stop-homeassistant stop-zigbee2mqtt stop-homeassistant_db
down : down-all


up-wireguard :
	docker-compose up --build -d wireguard

up-homeassistant :
	docker-compose up -d homeassistant

up-mosquitto :
	docker-compose up -d mosquitto

up-influxdb :
	docker-compose up -d influxdb

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

stop-influxdb :
	docker stop influxdb

stop-grafana :
	docker stop grafana

stop-zigbee2mqtt :
	docker stop zigbee2mqtt

stop-homeassistant_db :
	docker stop homeassistant_db


down-all :
	docker-compose down --remove-orphans