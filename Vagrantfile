# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

$vm_box = "ubuntu/xenial64"
# $vm_box = "centos/7"
$instances = 14
$python_command = "/usr/bin/python"
$bond_interface = "eth0"

if $vm_box == "ubuntu/xenial64"
  $bond_interface = "enp0s8"
  $python_command = "/usr/bin/python3"
elsif $vm_box == "centos/7"
  $bond_interface = "eth1"
end

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.box = $vm_box
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  if Vagrant.has_plugin?("vagrant-proxyconf") and $vm_box == "ubuntu/xenial64" then
    config.apt_proxy.http = "http://192.168.205.16:3142"
    config.apt_proxy.https = "DIRECT"
  end

  (1..$instances).each do |instance_id|
    if instance_id <= 3
      $vm_name = "es-master-#{instance_id}"
    elsif instance_id <= 6
      $vm_name = "es-hot-#{instance_id}"
    elsif instance_id <= 8
      $vm_name = "es-warm-#{instance_id}"
    elsif instance_id <= 11
      $vm_name = "redis-#{instance_id}"
    elsif instance_id <= 13
      $vm_name = "logstash-#{instance_id}"
    elsif instance_id == 14
      $vm_name = "kibana-#{instance_id}"
    end
    config.vm.define vm_name = $vm_name do |config|
      config.vm.hostname = vm_name
      config.vm.network "private_network", type: "dhcp"
      if $vm_name == "kibana-#{instance_id}"
        config.vm.network "forwarded_port", guest: 5601, host: 5601, auto_correct: true
        config.vm.network "forwarded_port", guest: 8600, host: 53, auto_correct: true
      end
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
        vb.name = vm_name
      end

      if instance_id == $instances
        config.vm.provision "ansible" do |ansible|
          ansible.extra_vars = {
            # ansible_python_interpreter: $python_command,
            bond_interface: $bond_interface
          }
          ansible.groups = {
            "elasticMasterNode" => ["es-master-[1:3]"],
            "elasticHotNode" => ["es-hot-[4:6]"],
            "elasticWarmNode" => ["es-warm-[7:8]"],
            "redis" => ["redis-[9:11]"],
            "logstash" => ["logstash-[12:13]"],
            "kibana" => ["kibana-14"],
            "elasticsearch:children" => ["elasticMasterNode","elasticHotNode","elasticWarmNode"],
            "elasticDataNode:children" => ["elasticHotNode","elasticWarmNode"],
            "python3" => [""]
          }
          ansible.limit = "all"
          ansible.playbook = "vagrant_playbook.yml"
        end
      end
    end
  end
end
