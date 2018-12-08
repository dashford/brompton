all : up

up : up-nginx up-letsencrypt up-homeassistant up-mosquitto up-influxdb up-grafana up-telegraf
stop : stop-nginx stop-letsencrypt stop-homeassistant stop-mosquitto stop-influxdb stop-grafana stop-telegraf
down : down-all


up-nginx :
	docker-compose -f docker-compose.prod.yml up -d nginx

up-letsencrypt :
	docker-compose -f docker-compose.prod.yml up -d letsencrypt

up-homeassistant :
	docker-compose -f docker-compose.prod.yml up -d homeassistant

up-mosquitto :
	docker-compose -f docker-compose.prod.yml up -d mosquitto

up-influxdb :
	docker-compose -f docker-compose.prod.yml up -d influxdb

up-grafana :
	docker-compose -f docker-compose.prod.yml up -d grafana

up-telegraf :
	docker-compose -f docker-compose.prod.yml up -d telegraf


stop-nginx :
	docker stop brompton_nginx_1

stop-letsencrypt :
	docker stop brompton_letsencrypt_1

stop-homeassistant :
	docker stop brompton_homeassistant_1

stop-mosquitto :
	docker stop brompton_mosquitto_1

stop-influxdb :
	docker stop brompton_influxdb_1

stop-grafana :
	docker stop brompton_grafana_1

stop-telegraf :
	docker stop brompton_telegraf_1


down-all :
	docker-compose down --remove-orphans