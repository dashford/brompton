teslamateversion = 1.27.1

all : up

up : up-wireguard up-mosquitto up-influxdb up-grafana up-homeassistant up-zigbee2mqtt up-homeassistant_db up-teslamate up-teslamate_db up-teslamateagile
stop : stop-wireguard stop-mosquitto stop-influxdb stop-grafana stop-homeassistant stop-zigbee2mqtt stop-homeassistant_db stop-teslamate stop-teslamate_db stop-teslamateagile
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

up-teslamate :
	docker-compose up -d teslamate

up-teslamate_db :
	docker-compose up -d teslamate_db

up-teslamateagile :
	docker-compose up -d teslamateagile


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

stop-teslamate :
	docker stop teslamate

stop-teslamate_db :
	docker stop teslamate_db

stop-teslamateagile :
	docker stop teslamateagile


down-all :
	docker-compose down --remove-orphans


update-teslamate-dashboards :
	curl --output /tmp/teslamate.tar.gz --location https://github.com/adriankumpf/teslamate/archive/refs/tags/v$(teslamateversion).tar.gz
	tar -zxvf /tmp/teslamate.tar.gz --directory /tmp
	cp --recursive /tmp/teslamate-$(teslamateversion)/grafana/dashboards/* ./docker/grafana/dashboards/teslamate