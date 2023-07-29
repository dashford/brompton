# Brompton

## Installation

Assumes a running version of Ubuntu.

### Install docker & docker compose

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
```

Verify docker & docker compose is running

```bash
docker run hello-world
docker compose version
```

### Set up repo

Generate the deploy key:

```bash
ssh-keygen -t ed25519 -C "brompton deploy key"
```

_Make a note of the filename of the key._

Navigate to https://github.com/dashford/brompton/settings/keys and add the public key.

Create the `~/.ssh/config` file matching github.com to the new deploy key

```bash
vi ~/.ssh/config
```

Copy the below into the file:

```bash
Host github.com
        Hostname github.com
        IdentityFile=/home/david/.ssh/github-brompton
```

Create directory for the repo:

```bash
mkdir -p ~/dashford
```

Clone the repo:

```bash
git clone git@github.com:dashford/brompton.git
```

Create a `.env` file in the root of the repo with contents from the `.env.example` file.

## Configuration

### Mosquitto

Start the container

```bash
docker compose up mosquitto -d
```

### Grafana

Start the container

```bash
docker compose up grafana -d
```

### InfluxDB

Start the container

```bash
docker compose up influxdb -d
```

### Zigbee2MQTT

Add the current user to the `dialout`, `tty`, and `uucp` groups:

```bash
sudo usermod -a -G uucp $USER
sudo usermod -a -G tty $USER
sudo usermod -a -G dialout $USER
```

Reboot the server.

Start the container

```bash
docker compose up zigbee2mqtt -d
```

### Teslamate

Start the container

```bash
docker compose up teslamate -d
```

To run this you will need to generate API tokens, following instructions for https://github.com/adriankumpf/tesla_auth.
You should install this on your local machine, not the server.

### Wireguard

Start the container

```bash
docker compose up wireguard -d
```

When the container starts on first run, a QR code will be generated. This can be used to quickly populate the wireguard
configuration on your client device. Perform the following changes:

- Remove `DNS servers` from the `Interface`.
- Change the `Endpoint` address to `79.97.250.243:52000`.
- Update the `Allowed IPs` to `10.0.0.0/8`.

### Home Assistant

Start the container

```bash
docker compose up homeassistant -d
```

#### Install HACS

Connect to the running Home Assistant container:

```bash
docker exec -it homeassistant /bin/bash
```

Install HACS:

```bash
wget -O - https://get.hacs.xyz | bash -
```

Restart Home Assistant.

Follow the official [configuration instructions](https://hacs.xyz/docs/configuration/basic).

#### Install Integrations

Add the following integrations through the [UI](http://10.243.0.100:8123/config/integrations):

##### MQTT

No further configuration required.

##### Met Éireann

No further configuration required.

##### LG

Further select LG webOS Smart TV.

##### Nest Protect

_Note: This should be configured through HACS_.

_Notes: The authentication mechanism is broken and fix is currently in beta._

Navigate to [HACS integrations](http://10.243.0.100:8123/hacs/integrations) and search for `Nest Protect`. Install and
restart Home Assistant.

After Home Assistant has restarted, navigate to the main [integrations](http://10.243.0.100:8123/config/integrations)
page and search for `Nest` again to configure the plugin.

##### myenergi

_Note: This should be configured through HACS_.

Navigate to [HACS integrations](http://10.243.0.100:8123/hacs/integrations) and search for `myenergi`. Install and
restart Home Assistant.

After Home Assistant has restarted, navigate to the main [integrations](http://10.243.0.100:8123/config/integrations)
page and search for `myenergi` again to configure the plugin.

Hub serial number and API key are stored in BitWarden.

After installation, re-configure the integration and update the `Update interval` to `180`.

##### Google

Navigate to the main [integrations](http://10.243.0.100:8123/config/integrations) page and search for `Google`. In the
submenus, select `Google Cast` and follow further instructions.

##### SIA Alarm Systems

[Documentation](https://www.home-assistant.io/integrations/sia/).

Select `8124` as the port and `B17` as the account ID. Get the encryption key from BitWarden and leave the rest as default.

##### Ubiquiti

Navigate to the main [integrations](http://10.243.0.100:8123/config/integrations) page and search for `Ubiquiti`. Select
`UniFi Network` when the following menu is presented.

Choose `10.243.0.1` as the `Host`; `homeassistant` as the `User`; select the password from the vault; leave `Port` as is.

Navigate to the `Entities` configuration for `UniFi` and enable the devices you wish to track.

##### WLED

*Note: This integration will likely be auto-dsicovered.*

Navigate to the main [integrations](http://10.243.0.100:8123/config/integrations) page and search for `WLED`. Follow the
instructions to configure.

##### Kodi

*Note: This integration will likely be auto-dsicovered.*

Navigate to the main [integrations](http://10.243.0.100:8123/config/integrations) page and search for `Kodi`.

#### Energy Configuration

_Note: This requires `myenergi` integration to be set up first._

Navigate to the [energy dashboard](http://10.243.0.100:8123/energy).