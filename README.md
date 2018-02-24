# Off-line way to deploy ElasticSearch/Logstash/Kibana

## Tested on these OS with [ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## Requirements
1. On ubuntu 16.04 LTS(xenial), you have to install `python-minimal` before ansible python scripts could be run on it remotely.
1. It's better if you have Internet access on this computer. otherwise, you need to download packages manually and copy into relate directories.

## Steps ##
1. Copy `hosts-example` to `hosts`, and edit it base on your real environment.
1. `ansible-playbook env_init.yml`
1. `ansible-playbook deploy_consul.yml`
1. `ansible-playbook deploy_elasticsearch.yml`
1. `ansible-playbook deploy_kibana.yml`
1. `ansible-playbook deploy_logstash.yml`
1. `ansible-playbook deploy_beats.yml`

## Maintain
### Upgrade
1. Set the value of 'elk_version' in `group_vars/all.yml`, then run following commands will rolling upgrade your services to the new version.
  1. `ansible-playbook deploy_elasticsearch.yml`
  1. `ansible-playbook deploy_kibana.yml`
  1. `ansible-playbook deploy_logstash.yml`

1. If any node added, removed or moved to other groups in `hosts` file, make sure you run the whole [Steps](#steps) again.

---

# 离线部署 ELK 服务。

## 本项目在以下操作系统测试通过。
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## 前提条件
1. Ubuntu 16.04 LTS（xenial） 需要安装 python-minimal，增加 python2.7 的支持。
1. 本机最好是有互联网访问权限。否则请自行下载对应的包并拷贝到相关目录里。

## 执行步骤
1. 按照 hosts-example 模板，同目录新建一个 hosts 文件， 根据实际环境填写机器信息。
1. `ansible-playbook env_init.yml`
1. `ansible-playbook deploy_consul.yml`
1. `ansible-playbook deploy_elasticsearch.yml`
1. `ansible-playbook deploy_kibana.yml`
1. `ansible-playbook deploy_logstash.yml`
1. `ansible-playbook deploy_beats.yml`

## 维护更新
### 升级
1. 修改 group_vars/all.yml 里的 elk_version 值，依次执行 elk 的 aplaybooks 即可滚动升级到最新版本。
1. 任何节点的增删，都需要重新按顺序执行一次所有 playbooks
