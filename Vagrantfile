# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

$vm_box = "ubuntu/xenial64"
# $vm_box = "centos/7"
# $instances = 3
$instances = 14
$apt_proxy = "http://192.168.205.12:3142"

Vagrant.configure("2") do |config|
  # always use Vagrants insecure key
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.box = $vm_box
  config.vm.synced_folder ".", "/vagrant", disabled: true

  if Vagrant.has_plugin?("vagrant-proxyconf") and $vm_box == "ubuntu/xenial64" then
    config.apt_proxy.http = $apt_proxy || ""
    config.apt_proxy.https = "DIRECT"
  end

  if $vm_box == "ubuntu/xenial64" then
    config.vm.provision "file", source: "apt_sources.list", destination: "/tmp/sources.list"
    config.vm.provision "shell", inline: "sudo mv -f /tmp/sources.list /etc/apt/sources.list"
    config.vm.provision "shell", inline: "sudo apt-get update"
    config.vm.provision "shell", inline: "sudo apt-get dist-upgrade -y --auto-remove"
    config.vm.provision "shell", inline: "sudo apt-get autoclean"
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV['HTTP_PROXY'] || ENV['http_proxy'] || ""
    config.proxy.https    = ENV['HTTPS_PROXY'] || ENV['https_proxy'] ||  ""
    config.proxy.no_proxy = $no_proxy
  end

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
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

      if $instances == 3
        config.vm.network "forwarded_port", guest: 5601, host: 5601,
          auto_correct: true
      end

      if $vm_name == "redis-#{instance_id.to_s.rjust(2, '0')}"
        config.vm.network "forwarded_port", guest: 15601, host: 5601,
          auto_correct: true
        config.vm.network "forwarded_port", guest: 19200, host: 9200,
          auto_correct: true
        config.vm.network "forwarded_port", guest: 15044, host: 5044,
          auto_correct: true
        config.vm.network "forwarded_port", guest: 16379, host: 6379,
          auto_correct: true
      end

      config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        vb.name = vm_name
        if $instances == 3
          vb.memory = "16384"
          vb.cpus = "4"
        else
          vb.memory = "2048"
          vb.cpus = "2"
        end
      end

      if instance_id == $instances
        config.vm.provision "ansible" do |ansible|
          if $instances == 14
            ansible.groups = {
              "esMasters" => ["es-master-[01:03]"],
              "esHots" => ["es-hot-[04:06]"],
              "esWarms" => ["es-warm-[07:08]"],
              "redis" => ["redis-[09:11]"],
              "logstash" => ["logstash-[12:13]"],
              "kibana" => ["kibana-14"],
              "haproxy" => ["redis-[09:11]"],
              "elasticsearch:children" => ["esMasters","esHots","esWarms"],
              "esDatas:children" => ["esHots","esWarms"]
            }
          end
          if $instances == 3
            ansible.groups = {
              "esMasters" => ["es-master-[01:03]"],
              "esHots" => "",
              "esWarms" => "",
              "redis" => "",
              "logstash" => ["es-master-[01:03]"],
              "kibana" => ["es-master-[01:03]"],
              "elasticsearch:children" => ["esMasters","esHots","esWarms"],
              "esDatas:children" => ["esHots","esWarms"]
            }
          end
          ansible.limit = "all"
          ansible.playbook = "play-all.yml"
        end
      end
    end
  end
end
