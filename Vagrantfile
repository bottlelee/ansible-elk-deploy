ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

$instances = 3
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

      #
      # $forwarded_ports.each do |guest, host|
      #   config.vm.network "forwarded_port", guest: guest, host: host, auto_correct: true
      # end
      if instance_id == $instances
        config.vm.provision "ansible" do |ansible|
          ansible.extra_vars = {
            ansible_python_interpreter: "/usr/bin/python3",
            check_groups: false,
            node_master: true,
            node_data: true,
            node_ingest: true,
            bond_interface: $bond_interface
          }

          ansible.groups = {
            "elasticMasterNode" => ["elk-[1:#{$instances}]"],
            "elasticHotNode" => ["elk-[1:#{$instances}]"],
            "elasticWarmNode" => ["elk-[1:#{$instances}]"],
            "kibana" => ["elk-[1:#{$instances}]"],
            "logstash" => ["elk-[1:#{$instances}]"],
            "elasticsearch:children" => ["elasticMasterNode","elasticHotNode","elasticWarmNode"]
          }

          ansible.limit = "all"
          ansible.playbook = "vagrant_playbook.yml"
        end
      end
    end
  end
end
