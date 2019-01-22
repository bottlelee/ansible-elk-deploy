---
title: "安装 Redis"
weight: 38
chapter: true
pre: "<b>3.8 </b>"
---

### 消息队列缓冲

# Redis

如果你不需要 Redis 可以跳过这一步。

这是一个 3 节点的 Redis 架构，1 主 2 从，通过 Sentinel 做主从监控和切换。

内部 Consul 域名是 redis.service.{{ consul_dc_name }}.consul

#### playbook 的组成

{{<mermaid align="left">}}
graph LR;
    Playbook(03-deploy_redis.yml)
    role[roles/deploy.Redis] --> Playbook
    template[templates/redis/] --> Playbook
    var1[group_vars/all.yml] --> Playbook
    var2[vars/redis_conf.yml] --> Playbook
{{< /mermaid >}}

#### 执行

```bash
$ ansible-playbook 03-deploy_redis.yml
```

顺利完成后，你可以在控制机的以下路径里看到相关的配置文件。

CentOS

- install_report/{{ inventory_hostname }}/etc/redis.conf
- install_report/{{ inventory_hostname }}/etc/sentinel.conf

Ubuntu

- install_report/{{ inventory_hostname }}/etc/redis-server.conf
- install_report/{{ inventory_hostname }}/etc/redis-sentinel.conf
