# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

$instances = 11
$bond_interface = "enp0s8"

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  (1..$instances).each do |instance_id|
    config.vm.define vm_name = "elk-#{instance_id}" do |config|
      config.vm.hostname = vm_name
      config.vm.network "private_network", type: "dhcp"
      config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
        vb.name = vm_name
      end

      if instance_id == $instances
        config.vm.provision "ansible" do |ansible|
          ansible.extra_vars = {
            ansible_python_interpreter: "/usr/bin/python3",
            bond_interface: $bond_interface
          }

          ansible.groups = {
            "elasticMasterNode" => ["elk-[1:3]"],
            "elasticHotNode" => ["elk-[4:6]"],
            "elasticWarmNode" => ["elk-[7:8]"],
            "elasticIngestNode" => ["elk-9"],
            "kibana" => ["elk-10"],
            "logstash" => ["elk-11"],
            "elasticsearch:children" => ["elasticMasterNode","elasticHotNode","elasticWarmNode"],
            "elasticDataNode:children" => ["elasticHotNode","elasticWarmNode"]
          }

          ansible.limit = "all"
          ansible.playbook = "vagrant_playbook.yml"
        end
      end
    end
  end
end
