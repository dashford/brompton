# Brompton

## Installation

Assumes a running version of Ubuntu.

### Configure HDDs

Create mount points:

```bash
mkdir -p /home/david/europa
mkdir -p /home/david/io
mkdir -p /home/david/callisto
mkdir -p /home/david/ganymede
```

Run `sudo vi /etc/fstab` and add the following:

```bash
UUID=4b9478a9-937d-4e20-b930-f6f0e6d73447	/home/david/europa	ext4	defaults	0	0
UUID=73a146b5-a720-4189-afdf-98ad7ffb949e	/home/david/ganymede	ext4	defaults	0	0
UUID=b2ca9bb2-f454-4de4-b2c5-5796604709d3	/home/david/callisto	ext4	defaults	0	0
UUID=cb9a0754-37ce-4506-a85b-e97f265d6bfe	/home/david/io	ext4	defaults	0	0
```

### Configure NFS

```bash
sudo apt install nfs-kernel-server
sudo chown -R nobody:nogroup /home/david/europa/ /home/david/callisto/ /home/david/ganymede/ /home/david/io/
sudo chmod 777 /home/david/europa/ /home/david/callisto/ /home/david/ganymede/ /home/david/io/
```

Run `sudo vi /etc/exports` and add the following:

```bash
/home/david/europa      10.243.0.0/16(rw,sync,no_subtree_check)
/home/david/callisto      10.243.0.0/16(rw,sync,no_subtree_check)
/home/david/ganymede      10.243.0.0/16(rw,sync,no_subtree_check)
/home/david/io      10.243.0.0/16(rw,sync,no_subtree_check)
```

Run:

```bash
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```

Configure firewall:

```bash
sudo ufw allow from 10.243.0.0/16 to any port nfs
sudo ufw enable
```

On client machine run `sudo vi /etc/fstab` and add the following:

```bash
10.243.0.100:/home/david/io  /home/david/jupiter/io  nfs     auto,nofail,noatime,nolock,intr,tcp,actimeo=1800        0       0
10.243.0.100:/home/david/europa      /home/david/jupiter/europa      nfs     auto,nofail,noatime,nolock,intr,tcp,actimeo=1800        0       0
```

### Set up `restic`

Download the latest release:

```bash
curl -L https://github.com/restic/restic/releases/download/v0.16.0/restic_0.16.0_linux_amd64.bz2 --output restic.bz2
bzip2 -d restic.bz2
chmod +x restic
sudo mv restic /usr/local/bin/restic-0.16.0
sudo ln -s /usr/local/bin/restic-0.16.0 /usr/local/bin/restic
```

#### Initialise the restic repo (Scaleway S3 backend)

Access keys stored in Vault.

```bash
export AWS_ACCESS_KEY_ID=SCW...
export AWS_SECRET_ACCESS_KEY=ds7ysdh-...

restic -r s3:https://s3.fr-par.scw.cloud/dashford-backup init
restic -r s3:https://s3.fr-par.scw.cloud/dashford-backup backup -o s3.storage-class=ONEZONE_IA /home/david/europa/dashford-backup/
```

#### Initialise the restic repo (Local backend)

```bash
restic init --repo /home/david/ganymede/dashford-backup
restic -r /home/david/ganymede/dashford-backup --verbose backup /home/david/europa/dashford-backup
```

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

#### Restoring from backup

First un-tar the backup file to a directory of your choice.

```bash
tar -xOf <backup>.tar "homeassistant.tar.gz" | tar --strip-components=1 -zxf - -C <restore directory>
```

Next the un-tarred directory needs to be mounted as a volume for the docker container e.g.

```bash
docker run --expose 8123 --network host --volume <resore directory>:/config homeassistant/home-assistant:2024.4.4
```

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