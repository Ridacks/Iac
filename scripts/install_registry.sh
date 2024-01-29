#!/bin/bash

## installation serveur postgresql

IP=$(hostname -I | awk '{print $2}')

echo "------------------------------------------------------"
echo "Démarrage - Installation Registre Docker - "$IP
echo "------------------------------------------------------"

echo "[1]: Installation utils & docker"
sudo apt-get -qq update
sudo apt-get -qq install -y vim git curl >/dev/null

echo " [2]: Installation docker & docker-compose"
apt-get -qq install -y ca-certificates curl gnupg >/dev/null
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list 2>/dev/null >/dev/null

apt-get -qq update 
apt-get -qq install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null

sudo curl -L https://github.com/docker/compose/releases/download/1.25.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER

systemctl restart docker

echo "[3]: Création des certificats TLS"
mkdir certs/
openssl req -x509 -newkey rsa:4096 -nodes -sha256 -keyout certs/registry.key -out certs/registry.crt -days 365 -subj /CN=myregistry.my
mkdir passwd/
sudo docker run --entrypoint htpasswd registry:2.7.0 -Bbn vagrant vagrant > passwd/htpasswd

echo "[4]: Création du docker compose registry"
mkdir data/
echo "
version: '3.5'
services:
  registry:
    restart: always
    image: registry:2.7.0
    container_name: registry
    ports:
      - 5000:5000
    environment:
      REGISTRY_HTTP_TLS_CERTIFICATE: /certs/registry.crt
      REGISTRY_HTTP_TLS_KEY: /certs/registry.key
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
    volumes:
      - ./data:/var/lib/registry
      - ./certs:/certs
      - ./passwd:/auth
" > docker-compose-registry.yml

echo "|4]: Lancement du container registry"
sudo docker-compose -f docker-compose-registry.yml up -d >/dev/null

echo "---------------------------"
echo "FIN - Installation terminée"
echo "---------------------------"