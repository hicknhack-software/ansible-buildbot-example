# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative '.vagrant-file' if File.exists?('.vagrant-file.rb')

Vagrant.configure('2') do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "private_network", type: "dhcp" # use this for communications
  config.vm.synced_folder ".", "/vagrant", disabled: true # only ansible-vm mounts
  config.ssh.insert_key = false # ease communication between machines

  # use vagrant-hostmanager plugin
  #   vagrant plugin install vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  # buildbot master
  config.vm.define "master-vm" do |master|
    master.vm.hostname = "master-vm"

    # forwarded ports
    master.vm.network "forwarded_port", guest: 8083, host: 8083 # webserver
  end

  # n buildbot workers
  (1..2).each do |n|
    config.vm.define "worker#{n}-vm" do |worker|
      worker.vm.hostname = "worker#{n}-vm"

      # make machine faster
      worker.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
      end
    end
  end

  config.vm.define "winworker1-vm" do |winworker|
    winworker.vm.box = "kensykora/windows_2012_r2_standard"
    winworker.vm.hostname = "winworker1-vm"

    winworker.vm.network :forwarded_port, guest: 3389, host: 33389, auto_correct: true

    # make machine faster
    winworker.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  end

  config.vm.define "ansible-vm", primary: true do |ansible|
    ansible.vm.hostname = "ansible-vm"
    ansible.vm.synced_folder ".", "/vagrant", :mount_options => ["fmode=666"]
    ansible.ssh.forward_agent = true
    customize_ansible_vm(ansible) if defined? customize_ansible_vm
  end
end
