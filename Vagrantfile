# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

$vm_box = "ubuntu/xenial64"
# $vm_box = "centos/7"
$memory = "16384"
$cpu = "4"
$instances = 3
$apt_proxy = "http://192.168.205.16:3142"

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.box = $vm_box
  config.vm.synced_folder ".", "/vagrant", disabled: true
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  if Vagrant.has_plugin?("vagrant-proxyconf") and $vm_box == "ubuntu/xenial64" and $apt_proxy != "" then
    config.apt_proxy.http = $apt_proxy
    config.apt_proxy.https = "DIRECT"
  end

  (1..$instances).each do |instance_id|
    if instance_id <= 3
      $vm_name = "es-master-#{instance_id.to_s.rjust(2, '0')}"
    elsif instance_id <= 6
      $vm_name = "es-hot-#{instance_id.to_s.rjust(2, '0')}"
    elsif instance_id <= 8
      $vm_name = "es-warm-#{instance_id.to_s.rjust(2, '0')}"
    elsif instance_id <= 11
      $vm_name = "redis-#{instance_id.to_s.rjust(2, '0')}"
    elsif instance_id <= 13
      $vm_name = "logstash-#{instance_id.to_s.rjust(2, '0')}"
    elsif instance_id == 14
      $vm_name = "kibana-#{instance_id.to_s.rjust(2, '0')}"
    end

    config.vm.define vm_name = $vm_name do |config|
      config.vm.hostname = vm_name
      config.vm.network "private_network", ip: "172.28.128.1#{instance_id.to_s.rjust(2, '0')}"

      if $vm_name == "kibana-#{instance_id.to_s.rjust(2, '0')}"
        config.vm.network "forwarded_port", guest: 5601, host: 5601,
          auto_correct: true
      end

      config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.memory = $memory
        vb.cpus = $cpu
        vb.name = vm_name
      end

      if instance_id == $instances
        config.vm.provision "ansible" do |ansible|
          if $instances == 14
            ansible.groups = {
              "elasticMasterNode" => ["es-master-[01:03]"],
              "elasticHotNode" => ["es-hot-[04:06]"],
              "elasticWarmNode" => ["es-warm-[07:08]"],
              "redis" => ["redis-[09:11]"],
              "logstash" => ["logstash-[12:13]"],
              "kibana" => ["kibana-14"],
              "elasticsearch:children" => ["elasticMasterNode","elasticHotNode","elasticWarmNode"],
              "elasticDataNode:children" => ["elasticHotNode","elasticWarmNode"]
            }
          end
          if $instances == 3
            ansible.groups = {
              "elasticMasterNode" => ["es-master-[01:03]"],
              "elasticHotNode" => "",
              "elasticWarmNode" => "",
              "redis" => "",
              "logstash" => ["es-master-[01:03]"],
              "kibana" => ["es-master-[01:03]"],
              "elasticsearch:children" => ["elasticMasterNode","elasticHotNode","elasticWarmNode"],
              "elasticDataNode:children" => ["elasticHotNode","elasticWarmNode"]
            }
          end
          ansible.limit = "all"
          ansible.playbook = "play-all.yml"
        end
      end
    end
  end
end
