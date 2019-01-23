---
title: "安装 Redis"
weight: 38
chapter: true
pre: "<b>3.8 </b>"
---

### 消息队列缓冲

# Redis

**如果你不需要 Redis，可以跳过这一步。**

内部 Consul 域名是 `redis.service.{{ consul_dc_name }}.consul`

# 架构示意图

这是一个 3 节点的 Redis 架构，1 主 2 从，通过 Sentinel 做主从监控和切换。参考 [Redis Sentinel Documentation](https://redis.io/topics/sentinel)

{{<mermaid align="center">}}
graph LR
  subgraph Redis Master
    ST1(Sentinel)-->RM(Redis Server)
  end

  subgraph Redis Slave
    ST2[Sentinel]-->RS2(Redis Server)
    RS2(Redis Server)==>RM
    ST2-.-ST1
  end

  subgraph Redis Slave
    ST3[Sentinel]-->RS3(Redis Server)
    RS3(Redis Server)==>RM
    ST3-.-ST2
    ST3-.-ST1
  end

  classDef blue fill:#0ff;

  class ST1,ST2,ST3 blue;

{{< /mermaid >}}

#### playbook 的组成

{{<mermaid align="left">}}
graph BT
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
