ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version ">= 2.0.0"

Vagrant.configure("2") do |config|

  (1..3).each do |i|
    config.vm.define "elk-#{i}" do |config|
      config.vm.box = "ubuntu/xenial64"
      config.vm.box_check_update = false
      config.vm.hostname = "elk-#{i}"
      config.vm.network "private_network", type: "dhcp"

      config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
        vb.name = "elk-#{i}"
      end
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3",
      check_groups: false
    }
    ansible.playbook = "01-env_init.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3",
      node_master: true,
      node_data: true,
      node_ingest: true
    }
    ansible.groups = {
      "elasticMasterNode" => ["elk-1","elk-2","elk-3"],
      "elasticsearch:children" => ["elasticMasterNode"]
    }
    ansible.playbook = "03-deploy_elasticsearch.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3"
    }
    ansible.playbook = "06-deploy_beats.yml"
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  config.vm.network "private_network", type: "dhcp"

  config.vm.define "kibana" do |config|
    config.vm.hostname = "kibana"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "1"
      vb.name = "kibana"
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3",
      check_groups: false
    }
    ansible.playbook = "01-env_init.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3"
    }
    ansible.groups = {
      "kibana" => ["elk-1","elk-2","elk-3"],
    }
    ansible.playbook = "04-deploy_kibana.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3"
    }
    ansible.playbook = "06-deploy_beats.yml"
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false
  config.vm.network "private_network", type: "dhcp"

  config.vm.define "logstash" do |config|
    config.vm.hostname = "logstash"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "1"
      vb.name = "logstash"
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3",
      check_groups: false
    }
    ansible.playbook = "01-env_init.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3"
    }
    ansible.groups = {
      "logstash" => ["elk-1","elk-2","elk-3"]
    }
    ansible.playbook = "05-deploy_logstash.yml"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3"
    }
    ansible.playbook = "06-deploy_beats.yml"
  end

end
