# -*- mode: ruby -*-
# # vi: set ft=ruby :
imagesDisk = 'images.vdi'

Vagrant.configure("2") do |config|
    Vagrant.require_version ">= 1.6.0"
    config.vm.box = ENV['BASEBOX'] || "panamax-coreos-box-367"
    config.vm.box_url = ENV['BASEBOX_URL'] || "http://storage.core-os.net/coreos/amd64-usr/367.1.0/coreos_production_vagrant.box"

    # Fix docker not being able to resolve private registry in VirtualBox
    config.vm.provider :virtualbox do |vb, override|
        vb.customize ['createhd', '--filename', imagesDisk, '--size', 32768]
        vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', imagesDisk]
    end

    # plugin conflict
    if Vagrant.has_plugin?("vagrant-vbguest") then
        config.vbguest.auto_update = false
    end
    config.vm.synced_folder ".", "/tmp", type: "rsync", rsync__exclude: "images*"
    #Docker Mount
    if ARGV[0] == "up" then
        config.vm.provision "shell", inline: "cd /tmp && sudo cp  format-ephemeral.service /etc/systemd/system && sudo systemctl start format-ephemeral.service"
        config.vm.provision "shell", inline: "cd /tmp && ./create-docker-mount"
        config.vm.provision "shell", inline: "docker pull 74.201.240.198:5000/panamax-api:latest && docker pull 74.201.240.198:5000/panamax-ui:latest && docker pull google/cadvisor:0.1.0"
    end
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.ssh.username = "core"
end
