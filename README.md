# Deploy ELK stack, ready for production.

## Note
All settings are use default value. I re-command you to have at least 3 nodes(8CPUs, 16GB memory, 128GB free disk space) to deploy your ELK cluster.

It's not ready for huge business before doing some tune up.

For test only, you can run `vagrant up`. You need [vagrant](https://www.vagrantup.com/), 22GB RAM and 22 CPUs on your single host.

## What we have in here?
1. Easy scale and rolling upgrade for ELK stack.
1. [Consul](https://www.consul.io/) as internal DNS service. Scale your ELK without updating the beats output configuration.
1. [Monit](https://mmonit.com/monit/documentation/monit.html) as monitoring service. Auto fix common issue, free you hands.

## Tested on these OS with [ansible 2.5.0](http://docs.ansible.com/ansible/latest/intro_installation.html)
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## Requirements
1. At least 4 CPUs, 8GB ram, 148G free disk space.

## Steps ##
1. Copy `hosts.sample` to `hosts`, and edit it base on your real environment.
1. Run `ansible-playbook 00-download.yml` if you haven't got any packages.
1. Run `ansible-playbook 01-env_init.yml` to initial all your hosts.
1. Run `ansible-playbook 03-deploy_elasticsearch.yml` to deploy elasticsearch cluster.
1. Run `ansible-playbook 04-deploy_kibana.yml` to deploy kibana.
1. Run `ansible-playbook 05-deploy_logstash.yml` to deploy logstash.
1. Run `ansible-playbook 06-deploy_beats.yml` to install beats agent for your ELK stack.

## DNS config
Any host that have `consul` installed，could be an internal DNS server. Please setup your system nameservers according different OS, or take a look at roles/deploy.Consul/tasks/resolv.yml

## How to send datas from outside hosts to ELK
1. Make sure outside hosts can access the ELK network.
1. Assume you are using beats as data collect client, use the `logstash` hosts' IP in output section, or you can use `logstash.service.consul` after you setup the [nameservers](#DNS config)

## Maintain
### Upgrade
1. Set the value of 'elk_version' in `group_vars/all.yml`, then run step 03 to 05 will rolling upgrade your services to the new version.
  1. `ansible-playbook deploy_elasticsearch.yml`
  1. `ansible-playbook deploy_kibana.yml`
  1. `ansible-playbook deploy_logstash.yml`

---

# 离线部署 ELK 服务。

## 注意
本项目适用于中型生产应用，建议在 3 个节点（至少 8 CPUs，16GB 内存，128GB 可用磁盘空间）上部署。

如果需要适配更高的业务需求，请联系 [新致云市场部](https://cloud.newtouch.com/support/business)。

测试本架构，运行`vagrant up`（你需要 [vagrant](https://www.vagrantup.com/)）。这将会消耗 22GB 内存和 22 个 CPU 线程。

## 本项目基于 [ansible 2.5.0](http://docs.ansible.com/ansible/latest/intro_installation.html) 在以下操作系统测试通过。
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## 前提条件
1. 最小配置：4 CPUs, 8GB 内存, 148G 空闲磁盘空间.

## 执行步骤
1. 按照 hosts.sample 模板，同目录新建一个 hosts 文件， 根据实际环境填写机器信息。
1. 执行 `ansible-playbook 00-download.yml` 确认安装所需的文件都已经下载好。
1. 执行 `ansible-playbook 01-env_init.yml` 初始化目标服务器的环境。
1. 执行 `ansible-playbook 03-deploy_elasticsearch.yml` 部署 elasticsearch 集群。
1. 执行 `ansible-playbook 04-deploy_kibana.yml` 部署 kibana，建议至少 2 个点。不要和 elastic-master 一起。
1. 执行 `ansible-playbook 05-deploy_logstash.yml` 部署 logstash。
1. 执行 `ansible-playbook 06-deploy_beats.yml` 部署 beats 客户端，默认把 ELK 的日志和资源状态等收集。

## DNS 设置
任意部署了 consul 服务的节点，都可以作为内部 DNS 服务器。请根据操作系统的不同，做相关的配置，或参考 roles/deploy.Consul/tasks/resolv.yml 里的用法。

## ELK 集群之外的机器，如果需要推送数据，需要满足以下条件：
1. 可访问本次部署的 ELK 集群网络。
1. 以 beats 为例，output 可以直接使用多个 logstash 节点的 IP。也可以在配置内部 DNS 后，使用 `logstash.service.consul` 来访问。

## 维护更新
### 升级
1. 修改 group_vars/all.yml 里的 elk_version 值，依次执行 03-05 即可滚动升级到最新版本。

## 鸣谢
本脚本在“新致云”提供的云主机上测试通过。[新致云](https://cloud.newtouch.com)，助你真正用好云计算。
