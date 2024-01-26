#!/bin/bash

## installation serveur postgresql

IP=$(hostname -I | awk '{print $2}')


echo "------------------------------------------------------"
echo "Démarrage - Installation PostgreSQL - "$IP
echo "------------------------------------------------------"

echo "[1]: Installation postgresql"
sudo apt-get -qq update
sudo apt-get -qq install -y vim git curl >/dev/null
sudo apt-get -qq install -y postgresql-15 2>/dev/null >/dev/null

echo "[2]: Création user vagrant"
sudo -u postgres bash -c "psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant';\""

echo "[3]: Création de la base de données DEV"
sudo -u postgres bash -c "psql -c \"CREATE DATABASE dev OWNER vagrant;\""

echo "[4]: Création de la base de données STAGE"
sudo -u postgres bash -c "psql -c \"CREATE DATABASE stage OWNER vagrant;\""

echo "[5]: Création de la base de données PROD"
sudo -u postgres bash -c "psql -c \"CREATE DATABASE prod OWNER vagrant;\""

echo "[6]: Configuration des adresses d écoute"
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf
sed -i "s/127.0.0.1\/32/0.0.0.0\/0/g" /etc/postgresql/15/main/pg_hba.conf

echo "[7]: Redémarrage du service postgresql"
sudo service postgresql restart

echo "---------------------------"
echo "FIN - Installation terminée"
echo "---------------------------"