---
title: "准备环境"
weight: 02
chapter: true
draft: false
---

# 你需要 1 台控制机

## 环境要求
1. Linux 系统（推荐使用 Ubuntu）。
2. 可以访问互联网。
3. 已安装了以下工具：
  1. python
  2. git
  3. wget

{{% notice tip %}}
你也可以选择 1 台目标服务器作为控制机。前提是它能访问外网。<br>
本文档所有操作以 Ubuntu linux 系统为例。
{{% /notice %}}

## 下载项目代码

#### 创建一个工作目录，例如 ~/Workspace/

```shell
mkdir ~/Workspace

git clone -b searchguard https://gitee.com/bottlelee/ansible-elk-deploy ~/Workspace/ansible-elk-deploy

cd ~/Workspace/ansible-elk-deploy
```

#### 目录说明

```
├── downloaded_files              # 文件下载目录
├── group_vars                    # ansible group_vars 目录
├── host_vars                     # 目标服务器的特定变量文件
├── roles                         # ansible roles 目录
│   ├── deploy.Beats              
│   ├── deploy.Chrony
│   ├── deploy.Consul
│   ├── deploy.Curator
│   ├── deploy.ElasticSearch
│   ├── deploy.Kibana
│   ├── deploy.Logstash
│   ├── deploy.Monit
│   ├── deploy.Redis
│   ├── deploy.SearchGuard
│   ├── init
│   └── test.RandomReboot
├── templates                     # 各个 role 对应的 templates 文件目录
│   ├── chrony
│   ├── consul
│   ├── curator
│   ├── elasticsearch
│   ├── filebeat
│   ├── init
│   ├── kibana
│   ├── logstash
│   ├── metricbeat
│   ├── packetbeat
│   ├── redis
│   └── searchguard
└── vars                           # 各个 role 对应的 vars 文件目录
```

{{% notice note %}}
我把各个 role 的 templates 目录存放在项目根目录下，这样便于查找编辑。
{{% /notice %}}

#### 安装 ansible
```bash
bash bootstrap-ansible.sh
```

#### 如果看到类似于以下信息的输出，表明 ansible 安装成功。
```bash
ansible 2.7.5
  config file = None
  configured module search path = [u'/home/haibin/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python2.7/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 2.7.15rc1 (default, Nov 12 2018, 14:31:15) [GCC 7.3.0]
```
