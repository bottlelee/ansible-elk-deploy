# Deploy ELK stack, ready for production.

[中文说明](README-cn.md)

## Note
All settings are use default value. I re-command you to have at least 3 nodes(8CPUs, 16GB memory, 128GB free disk space) to deploy your ELK cluster.

It's not ready for huge business before doing some tune up.

For test only, you can run `vagrant up`. You need [vagrant](https://www.vagrantup.com/), 22GB RAM and 22 CPUs on your single host.

## What we have in here?
1. Easy scale and rolling upgrade for ELK stack.
1. [Consul](https://www.consul.io/) as internal DNS service. Scale your ELK without updating the beats output configuration.
1. [Monit](https://mmonit.com/monit/documentation/monit.html) as monitoring service. Auto fix common issue, free you hands.

## Tested on these OS with [ansible 2.7.2](http://docs.ansible.com/ansible/latest/intro_installation.html)
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## Requirements
1. At least 4 CPUs, 8GB ram, 148G free disk space.

## Steps ##
1. Copy `hosts.ini.sample` to `hosts.ini`, and edit it base on your real environment.
1. Edit files under `vars` and `templates` to suit your requirements.
1. Run `ansible-playbook 00-download.yml` if you haven't got any packages.
1. Run `ansible-playbook play-all.yml` to start a fresh deploy.

## How to send data to ELK from outside hosts
1. Make sure outside hosts can access the ELK network.
1. Assume you are using beats as data collect client, use the `logstash` host IP in output section.

## Maintain
### Upgrade
1. Set the value of 'elk_version' in `group_vars/all.yml`, then run `ansible-playbook 98-upgrade_elk_cluster.yml` will rolling upgrade your services to the new version.

## Read more in [handbook](docs/handbook.md)
