# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", type: "dhcp" # use this for communications
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["fmode=666"]
  config.ssh.insert_key = false

  # use vagrant-hostmanager plugin
  #   vagrant plugin install vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  # buildbot master
  config.vm.define "buildbot-vm" do |buildbot|
    buildbot.vm.hostname = "buildbot-vm"

    # forwarded ports
    buildbot.vm.network "forwarded_port", guest: 8020, host: 8083 # webserver

    # disable shared folder
    buildbot.vm.synced_folder ".", "/vagrant", disabled: true
  end

  # n buildbot slaves
  (1..2).each do |n|
  config.vm.define "slave#{n}-vm" do |slave1|
    slave1.vm.hostname = "slave#{n}-vm"

    # disable shared folder
    slave1.vm.synced_folder ".", "/vagrant", disabled: true

    # make machine faster
    slave1.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  end

  config.vm.define "ansible-vm", primary: true do |ansible|
    ansible.vm.hostname = "ansible-vm"
    ansible.ssh.forward_agent = true
  end
end
