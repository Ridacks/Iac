#-*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Machine Jenkins
    config.vm.define "jenkins" do |jenkins|
        jenkins.vm.box = "debian/bookworm64"
        jenkins.vm.hostname = "jenkins"
        jenkins.vm.box_url = "debian/bookworm64"
        jenkins.vm.network :private_network, ip: "192.168.10.2"
        jenkins.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 3072]
            v.customize ["modifyvm", :id, "--name", "jenkins"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
        jenkins.vm.provision "shell", path: "scripts/install_jenkins.sh"
    end

    # Serveur de développement
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

    # # Serveur d'integration
    # config.vm.define "srvstage" do |srvstage|
    #     srvstage.vm.box = "debian/bookworm64"
    #     srvstage.vm.hostname = "srvstage"
    #     srvstage.vm.box_url = "debian/bookworm64"
    #     srvstage.vm.network :private_network, ip: "192.168.10.4"
    #     srvstage.vm.provider :virtualbox do |v|
    #         v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #         v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    #         v.customize ["modifyvm", :id, "--memory", 512]
    #         v.customize ["modifyvm", :id, "--name", "srvstage"]
    #         v.customize ["modifyvm", :id, "--cpus", "1"]
    #     end
    #     config.vm.provision "shell", path: "config_sshd.sh"
    # end  

    # # Serveur de production
    # config.vm.define "srvprod" do |srvprod|
    #     srvprod.vm.box = "debian/bookworm64"
    #     srvprod.vm.hostname = "srvprod"
    #     srvprod.vm.box_url = "debian/bookworm64"
    #     srvprod.vm.network :private_network, ip: "192.168.10.6"
    #     srvprod.vm.provider :virtualbox do |v|
    #         v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #         v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    #         v.customize ["modifyvm", :id, "--memory", 512]
    #         v.customize ["modifyvm", :id, "--name", "srvprod"]
    #         v.customize ["modifyvm", :id, "--cpus", "1"]
    #     end
    #     config.vm.provision "shell", path: "config_sshd.sh"
    # end 
    
    # Serveur de base de données dev
    config.vm.define "bdddev" do |bdddev|
        bdddev.vm.box = "debian/bookworm64"
        bdddev.vm.hostname = "bdddev"
        bdddev.vm.box_url = "debian/bookworm64"
        bdddev.vm.network :private_network, ip: "192.168.10.7"

        bdddev.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "bdddev"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
        bdddev.vm.provision "shell", path: "scripts/install_postgres.sh"
    end

    #  # Serveur de base de données stage
    #  config.vm.define "bddstage" do |bddstage|
    #     bddstage.vm.box = "debian/bookworm64"
    #     bddstage.vm.hostname = "bddstage"
    #     bddstage.vm.box_url = "debian/bookworm64"
    #     bddstage.vm.network :private_network, ip: "192.168.10.8"
    #     bddstage.vm.provider :virtualbox do |v|
    #         v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #         v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    #         v.customize ["modifyvm", :id, "--memory", 512]
    #         v.customize ["modifyvm", :id, "--name", "bddstage"]
    #         v.customize ["modifyvm", :id, "--cpus", "1"]
    #     end
    #     config.vm.provision "shell", path: "config_sshd.sh"
    #     bddstage.vm.provision "shell", path: "scripts/install_postgres.sh"
    # end

    # # Serveur de base de données prod
    # config.vm.define "bddprod" do |bddprod|
    #     bddprod.vm.box = "debian/bookworm64"
    #     bddprod.vm.hostname = "srvbddprod"
    #     bddprod.vm.box_url = "debian/bookworm64"
    #     bddprod.vm.network :private_network, ip: "192.168.10.9"
    #     bddprod.vm.provider :virtualbox do |v|
    #         v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #         v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    #         v.customize ["modifyvm", :id, "--memory", 512]
    #         v.customize ["modifyvm", :id, "--name", "bddprod"]
    #         v.customize ["modifyvm", :id, "--cpus", "1"]
    #     end
    #     config.vm.provision "shell", path: "config_sshd.sh"
    #     bddprod.vm.provision "shell", path: "scripts/install_postgres.sh"
    # end

    # Serveur registre Docker
    config.vm.define "registry" do |registry|
        registry.vm.box = "debian/bookworm64"
        registry.vm.hostname = "registry"
        registry.vm.box_url = "debian/bookworm64"
        registry.vm.network :private_network, ip: "192.168.10.5"
        registry.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "registry"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
        registry.vm.provision "shell", path: "scripts/install_registry.sh"
    end

    # Serveur gitlab
    config.vm.define "gitlab" do |gitlab|
        gitlab.vm.box = "debian/bookworm64"
        gitlab.vm.hostname = "gitlab"
        gitlab.vm.box_url = "debian/bookworm64"
        gitlab.vm.network :private_network, ip: "192.168.10.10"
        gitlab.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 4096]
            v.customize ["modifyvm", :id, "--name", "gitlab"]
            v.customize ["modifyvm", :id, "--cpus", "4"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
        gitlab.vm.provision "shell", path: "scripts/install_gitlab.sh"
    end

    # Serveur gitlab-runner
    config.vm.define "gitlab-runner" do |runner|
        runner.vm.box = "debian/bookworm64"
        runner.vm.hostname = "gitlab-runner"
        runner.vm.box_url = "debian/bookworm64"
        runner.vm.network :private_network, ip: "192.168.10.11"
        runner.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 512]
            v.customize ["modifyvm", :id, "--name", "gitlab-runner"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", path: "config_sshd.sh"
        runner.vm.provision "shell", path: "scripts/install_gitlab-runner.sh"
    end

end