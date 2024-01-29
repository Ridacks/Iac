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

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
apt-get -qq update


echo "[3]: Configuration des locales"
# sudo dpkg-reconfigure locales
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo "------------------------"
echo "[4]: Installation gitlab"
echo "------------------------"
apt install gitlab-ce -y 
sudo gitlab-ctl reconfigure

echo "-----------------------------"
echo "[5]: Monitoring status gitlab"
echo "-----------------------------"
sudo gitlab-ctl status

echo "-----------------------------------------"
echo "[6]: Mot de passe gitlab - 1ère connexion"
echo "-----------------------------------------"
sudo cat /etc/gitlab/initial_root_password

echo "---------------------------"
echo "FIN - Installation terminée"
echo "---------------------------"