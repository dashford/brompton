all : up

up : up-acmesh up-nginx up-homeassistant up-mosquitto up-influxdb up-grafana up-telegraf
stop : stop-acmesh stop-nginx stop-homeassistant stop-mosquitto stop-influxdb stop-grafana stop-telegraf
down : down-all


up-nginx :
	docker-compose -f docker-compose.prod.yml up -d nginx-proxy

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

up-acmesh :
	docker-compose -f docker-compose.prod.yml up -d acme.sh
	docker exec acme.sh --issue -d *.dashford.io --dns dns_cf --force
	docker exec acme.sh --install-cert -d *.dashford.io \
        --key-file /etc/acme.sh/ssl/privkey.pem  \
        --fullchain-file /etc/acme.sh/ssl/fullchain.pem \
        --ca-file /etc/acme.sh/ssl/chain.pem


stop-nginx :
	docker stop nginx-proxy

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