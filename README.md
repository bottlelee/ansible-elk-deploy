# 离线部署 ELK 服务。

## 本项目在以下操作系统测试通过。
* Ubuntu 16.04 LTS（xenial）
* CentOS 7

## 前提条件
1. Ubuntu 16.04 LTS（xenial） 需要安装 python-minimal，增加 python2.7 的支持。
1. 本机最好是有互联网访问权限。

## 执行步骤
1. 按照 hosts-example 模板，同目录新建一个 hosts 文件， 根据实际环境填写机器信息。
1. ansible-playbook env_init.yml
1. ansible-playbook deploy_elasticsearch.yml
1. ansible-playbook deploy_kibana.yml
1. ansible-playbook deploy_logstash.yml
