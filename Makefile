all : up

up : up-acmesh up-nginx up-mosquitto up-influxdb up-grafana up-telegraf
stop : stop-acmesh stop-nginx stop-mosquitto stop-influxdb stop-grafana stop-telegraf
down : down-all


up-nginx :
	docker-compose up -d nginx

up-homeassistant :
	docker-compose up -d homeassistant

up-mosquitto :
	docker-compose up -d mosquitto

up-influxdb :
	docker-compose up -d influxdb

up-grafana :
	docker-compose up -d grafana

up-telegraf :
	docker-compose up -d telegraf

up-acmesh :
	docker-compose up -d acme.sh
	docker exec acme.sh --issue -d *.dashford.io --dns dns_cf --force
	docker exec acme.sh --install-cert -d *.dashford.io \
        --key-file /acme.sh/*.dashford.io/key.pem  \
        --cert-file /acme.sh/*.dashford.io/cert.pem \
        --fullchain-file /acme.sh/*.dashford.io/full.pem \
        --ca-file /acme.sh/*.dashford.io/ca.pem


stop-nginx :
	docker stop nginx

stop-homeassistant :
	docker stop homeassistant

stop-mosquitto :
	docker stop mosquitto

stop-influxdb :
	docker stop influxdb

stop-grafana :
	docker stop grafana

stop-telegraf :
	docker stop telegraf

stop-acmesh :
	docker stop acme.sh


down-all :
	docker-compose down --remove-orphans