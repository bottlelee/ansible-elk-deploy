# Off-line way to deploy ElasticSearch/Logstash/Kibana

## Note
This is a baseline example. I re-command you to have at least 3 nodes(8CPUs, 16GB memory, 100GB disk space) to deploy your ELK cluster.
It's not ready for huge business before doing some tune up.

## What we have in here?
1. Easy scale and rolling upgrade for ELK components
1. [Consul](https://www.consul.io/) as internal DNS service. Scale your ELK without updating the beats output configuration.
1. [Monit](https://mmonit.com/monit/documentation/monit.html) as monitoring service. Auto fix common issue, free you hands.

## Tested on these OS with [ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## Requirements
1. At least 4 CPUs, 8GB ram, 148G free disk space.

## Steps ##
1. Copy `hosts.sample` to `hosts`, and edit it base on your real environment.
1. Run `ansible-playbook 00-download.yml`
1. Run `ansible-playbook 01-env_init.yml`
1. Run `ansible-playbook 02-deploy_consul.yml`
1. Run `ansible-playbook 03-deploy_elasticsearch.yml`
1. Run `ansible-playbook 04-deploy_kibana.yml`
1. Run `ansible-playbook 05-deploy_logstash.yml`
1. Run `ansible-playbook 06-deploy_beats.yml`
1. Run `ansible-playbook 07-deploy_monit.yml`

## Maintain
### Upgrade
1. Set the value of 'elk_version' in `group_vars/all.yml`, then run step 03 to 05 will rolling upgrade your services to the new version.
  1. `ansible-playbook deploy_elasticsearch.yml`
  1. `ansible-playbook deploy_kibana.yml`
  1. `ansible-playbook deploy_logstash.yml`

---

# 离线部署 ELK 服务。

## 注意
本项目只适用于小型应用，建议在 3 个节点（至少 8 CPUs，16GB 内存，128GB 可用磁盘空间）上部署。
如果需要适配更高的业务需求，请联系 [新致云](https://cloud.newtouch.com) 市场部。

## 本项目在以下操作系统测试通过。
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## 前提条件
1. 最小配置：4 CPUs, 8GB 内存, 148G 空闲磁盘空间.

## 执行步骤
1. 按照 hosts.sample 模板，同目录新建一个 hosts 文件， 根据实际环境填写机器信息。
1. 执行 `ansible-playbook 00-download.yml`
1. 执行 `ansible-playbook 01-env_init.yml`
1. 执行 `ansible-playbook 02-deploy_consul.yml`
1. 执行 `ansible-playbook 03-deploy_elasticsearch.yml`
1. 执行 `ansible-playbook 04-deploy_kibana.yml`
1. 执行 `ansible-playbook 05-deploy_logstash.yml`
1. 执行 `ansible-playbook 06-deploy_beats.yml`
1. 执行 `ansible-playbook 07-deploy_monit.yml`

## 维护更新
### 升级
1. 修改 group_vars/all.yml 里的 elk_version 值，依次执行 03-05 即可滚动升级到最新版本。

## 鸣谢
[新致云](https://cloud.newtouch.com)，助你真正用好云计算。
