#-*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define "jenkins-pipeline" do |jenkins|
        jenkins.vm.box = "debian/bookworm64"
        jenkins.vm.hostname = "jenkins-pipeline"
        jenkins.vm.box_url = "debian/bookworm64"
        jenkins.vm.network :private_network, ip: "192.168.10.2"
        jenkins.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 3072]
            v.customize ["modifyvm", :id, "--name", "jenkins-pipeline"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
        jenkins.vm.provision "shell", path: "install_jenkins.sh"
    end
end