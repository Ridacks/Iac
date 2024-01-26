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

    config.vm.define "srvdev" do |srvdev|
        srvdev.vm.box = "debian/bookworm64"
        srvdev.vm.hostname = "srvdev"
        srvdev.vm.box_url = "debian/bookworm64"
        srvdev.vm.network :private_network, ip: "192.168.10.3"
        srvdev.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "srvdev"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
    end  

    config.vm.define "srvstage" do |srvstage|
        srvstage.vm.box = "debian/bookworm64"
        srvstage.vm.hostname = "srvstage"
        srvstage.vm.box_url = "debian/bookworm64"
        srvstage.vm.network :private_network, ip: "192.168.10.7"
        srvstage.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "srvstage"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
    end  

    config.vm.define "srvprod" do |srvprod|
        srvprod.vm.box = "debian/bookworm64"
        srvprod.vm.hostname = "srvprod"
        srvprod.vm.box_url = "debian/bookworm64"
        srvprod.vm.network :private_network, ip: "192.168.10.4"
        srvprod.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "srvprod"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
    end  

end