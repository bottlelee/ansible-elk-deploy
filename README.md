# Deploy ELK stack, ready for production.

[中文文档](https://www.ansible-elk.cn)

## Note
All settings are use default value. I re-command you to have at least 3 nodes(8CPUs, 16GB memory, 128GB free disk space) to deploy your ELK cluster.

It's not ready for huge business before doing some tune up.

For test only, you can run `vagrant up`. You need [vagrant](https://www.vagrantup.com/), 22GB RAM and 22 CPUs on your single host.

## What we have in here?
1. Easy scale and rolling upgrade for ELK stack.
1. [Consul](https://www.consul.io/) as internal DNS service. Scale your ELK without updating the beats output configuration.
1. [Monit](https://mmonit.com/monit/documentation/monit.html) as monitoring service. Auto fix common issue, free you hands.

## Test results with [ansible 2.7.2](http://docs.ansible.com/ansible/latest/intro_installation.html)

| Elastic version | Ubuntu Server 16.04 | CentOS 7 |
| --------------- | ------------------- | -------- |
| 6.5.1           | Yes                 | Yes      |
| 6.4.0           | Yes                 | Yes      |

## Read documents at https://www.ansible-elk.cn

## FAQ
