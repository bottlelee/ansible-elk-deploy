# 离线部署 ELK 服务。

## 注意
本项目适用于中型生产应用，建议在 3 个节点（至少 8 CPUs，16GB 内存，128GB 可用磁盘空间）上部署。

如果需要适配更高的业务需求，请联系 [新致云市场部](https://cloud.newtouch.com/support/business)。

测试本架构，运行`vagrant up`（你需要 [vagrant](https://www.vagrantup.com/)）。这将会消耗 22GB 内存和 22 个 CPU 线程。

## 本项目基于 [ansible 2.7.2](http://docs.ansible.com/ansible/latest/intro_installation.html) 测试通过以下版本和环境。

| Elastic version | Ubuntu Server 16.04 | CentOS 7 |
| --------------- | ------------------- | -------- |
| 6.5.1           | Yes                 | Yes      |
| 6.4.0           | Yes                 | Yes      |

## 前提条件
1. 最小配置：4 CPUs, 8GB 内存, 148G 空闲磁盘空间.

## 执行步骤
1. 按照 hosts.ini.sample 模板，同目录新建一个 hosts.ini 文件， 根据实际环境填写机器信息。
1. 按照实际需求，编辑本目录下的 vars 和 templates 目录里相关文件。
1. 执行 `ansible-playbook 00-download.yml` 确认安装所需的文件都已经下载好。
1. 执行 `ansible-playbook play-all.yml` 进行全新部署。

## 详细步骤在 [handbook](docs/handbook.md)

## ELK 集群之外的机器，如果需要推送数据，需要满足以下条件：
1. 可访问本次部署的 ELK 集群网络。
1. 以 beats 为例，output 可以直接使用多个 logstash 节点的 IP。

## 维护更新
### 升级
1. 修改 group_vars/all.yml 里的 elk_version 值，执行 `ansible-playbook 98-upgrade_elk_cluster.yml` 即可滚动升级到最新版本。

## 鸣谢
本脚本在“新致云”提供的云主机上测试通过。[新致云](https://cloud.newtouch.com)，助你真正用好云计算。
