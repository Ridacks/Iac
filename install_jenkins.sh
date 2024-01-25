#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

## installation Jenkins
IP=$(hostname -I | awk '{print $2}')

echo "------------------------------------------------------"
echo "Démarrage - Installation Jenkins - "$IP
echo "------------------------------------------------------"

echo "[1]: Installation utils & ansible"
apt-get -qq update
apt-get install -y -qq git sshpass wget ansible gnupg2 curl 2>/dev/null >/dev/null
dpkg --configure 2>/dev/null >/dev/null

echo "[2]: Installation Java & Jenkins"
wget -q -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list 2>/dev/null >/dev/null

apt-get -qq update
apt-get -qq install default-jre jenkins -y 2>/dev/null >/dev/null

systemctl enable jenkins
systemctl restart jenkins

echo "[3]: Customisation Ansible"
sudo mkdir /etc/ansible
sudo touch /etc/ansible/ansible.cfg
sed -i 's/.*pipelining.*/pipelining = True/' /etc/ansible/ansible.cfg
sed -i 's/.*allow_world_readable_tmpfiles.*/allow_world_readable_tmpfiles = True/' /etc/ansible/ansible.cfg

echo " [4]: Installation docker & docker-compose"
apt-get -qq -y install ca-certificates curl gnupg 2>/dev/null
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list 2>/dev/null >/dev/null

apt-get -qq update 
apt-get -qq install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2>/dev/null

echo "[5]: use registry without ssl"
echo "
{
    "\"insecure-registries\"": [\"192.168.10.5:5000\"]
}" > /etc/docker/daemon.json

sudo usermod -aG docker $USER

systemctl daemon-reload
systemctl restart docker

echo "[6]: Initial password for jenkins"
cat /var/lib/jenkins/secrets/initialAdminPassword

echo "---------------------------"
echo "FIN - Installation terminée"
echo "---------------------------"