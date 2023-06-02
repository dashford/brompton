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

### Home Assistant

Start the container

```bash
docker compose up homeassistant -d
```

Add the following integrations through the [UI](http://10.243.0.100:8123/config/integrations):

- MQTT
