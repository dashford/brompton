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

Navigate to https://github.com/dashford/brompton/settings/keys and add the public key.

Create directory for the repo:

```bash
mkdir -p ~/dashford
```

Clone the repo:

```bash
git clone git@github.com:dashford/brompton.git
```

Create a `.env` file in the root of the repo with contents from the `.env.example` file.