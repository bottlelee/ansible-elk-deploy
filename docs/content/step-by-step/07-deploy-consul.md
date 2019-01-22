---
title: "安装 Consul"
weight: 37
chapter: true
pre: "<b>3.7 </b>"
---

### 分布式服务网格

# Consul

Consul 是一个分布式服务网格，用于跨平台的，公共云或私有云的连接、保护和配置服务。

#### 主要作用

服务发现并注册。通过对服务的定义，Consul 能发现本机存在的相关服务并通知到整个 Consul 集群，各服务之间通过内部域名进行访问，而实现整个 ELK 集群可以平滑扩缩，无需修改访问配置。

#### playbook 的组成

{{<mermaid align="left">}}
graph LR;
    Playbook(02-deploy_consul.yml)
    role[roles/deploy.Consul] --> Playbook
    template[templates/consul/] --> Playbook
    var1[group_vars/all.yml] --> Playbook
{{< /mermaid >}}

#### 执行

```bash
$ ansible-playbook 02-deploy_consul.yml
```

顺利完成后，你可以在 install_report/{{ inventory_hostname }}/etc/consul.d 里看到相关的配置文件。

#### Web UI

Consul 自带一个 Web UI，你可以访问任一机器的 8500 端口进行查看。

![Consul UI](../images/consul_ui.png)
