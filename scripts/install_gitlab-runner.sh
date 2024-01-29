#! /bin/bash


## installation serveur gitlab

IP=$(hostname -I | awk '{print $2}')


echo "------------------------------------------------------"
echo "Démarrage - Installation Gitlab - "$IP
echo "------------------------------------------------------"

echo "-----------------------"
echo "[1]: Installation utils"
echo "-----------------------"
apt-get -qq update
apt-get install -y vim git curl wget openssh-server ca-certificates perl 

echo "-------------------------------"
echo "[2]: récuperation script gitlab"
echo "-------------------------------"

curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
apt-get -qq update

echo "------------------------"
echo "[4]: Installation gitlab"
echo "------------------------"
sudo apt-get install -y gitlab-runner

echo "---------------------------"
echo "FIN - Installation terminée"
echo "---------------------------"