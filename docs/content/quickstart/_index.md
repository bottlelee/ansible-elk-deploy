---
title: "快速开始"
weight: 10
chapter: true
---

# Vagrant + Virtualbox

{{% notice warning %}}
注意：快速开始是以本地创建 3 台虚拟机并部署 ELK 为例。需要消耗大约 24GB 内存和 12 个 CPU 线程。
{{% /notice %}}

## 安装 Vagrant
#### 根据你的系统平台，访问 https://www.vagrantup.com/downloads.html 下载并安装对应版本的 Vagrant。

## 安装 VirtualBox
#### 根据你的系统平台，访问 https://www.virtualbox.org/wiki/Linux_Downloads 下载并安装对应版本的 VirtualBox

## 进入项目目录

```bash
cd ~/Workspace/ansible-elk-deploy
```

## 启动虚拟机

``` bash
vagrant up
```

{{% notice info %}}
**注意**</br>
第一次部署，需要下载虚拟机镜像。 这个时间会有点长。<br/>
然后会自动执行 ansible playbook，进行 ELK 部署。
{{% /notice %}}
