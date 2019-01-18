---
title: "修改 hosts.ini"
description: "hosts.ini 里该怎么填写？"
weight: 32
chapter: true
pre: "<b>3.2 </b>"
---

### 定义你的 hosts.ini

# 你要面对的架构

这里我已经准备了一个 `hosts.ini.example`，请在项目根目录下找到它，复制为 `hosts.ini` 并编辑。

```bash
$ cp hosts.ini.example hosts.ini
$ nano hosts.ini
```

接下来我们要设定每个 group 的成员。

{{% notice info %}}
在这里，我假设你对 ansible inventory 已经有了解。如果不是，请先阅读 [Working with Inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html) 获取相关知识。

下文的 IP 都是样例数据，请根据你的实际情况修改。
{{% /notice %}}

# 必填组

## 「esMasters」集群 master 节点。

```ini
# ElasticSearch master nodes and Consul servers.
# IMPORTANT: At least 3 nodes to avoid brain-split.
# Read more on https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#master-node
# More settings in `group_vars/esMasters.yml` file.
[esMasters]
es-master-1 ansible_host=172.23.56.103
es-master-2 ansible_host=172.23.56.105
es-master-3 ansible_host=172.23.56.108
```

这个组是必填，至少需要 3 台服务器。如果你的集群只有这 3 台服务器（最小集群），那么它们会同时担任 data 和 ingest 的角色，处理 pipeline，以及存储 ES 的数据。

Master 角色是负责管控整个 ES 集群的内部状态的。3 个节点会选举出 1 个 master，由它来同步整个集群的信息状态。

# 选填组（可留空）

## 「esIngest」ElasticSearch 的 ingest 角色。

```ini
# ElasticSearch ingest node.(Optional)
# IMPORTANT: If you don't need this group, please set `node_ingest: true` in `group_vars/esMasters.yml` file.
# Read more on https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#node-ingest-node
# More settings in `group_vars/esIngest.yml` file.
[esIngest]
```

该组应用在高负载 pipline 处理的场景中，它们只负责处理 [ingest pipeline](https://www.elastic.co/guide/en/elasticsearch/reference/current/pipeline.html)，不担任 master 和 data 角色。

如果你不了解或没这样的应用场景，就留空。

## 「esHots」ES 中负责存储热数据的节点。

```ini
# ElasticSearch hot data node, where newest data will be stored. Re-commanded for SSD storage
# IMPORTANT: At least 3 nodes
# Read more on https://www.elastic.co/blog/hot-warm-architecture
# More settings in `group_vars/elasticDataNode.yml` file.
[esHots]
es-hot-1 ansible_host=172.23.56.111
es-hot-2 ansible_host=172.23.56.112
es-hot-3 ansible_host=172.23.56.113
```

在 ES 里，有一种[冷热数据分离的架构](https://www.elastic.co/blog/hot-warm-architecture)设计，属于中大型生产环境使用的。也就是说，如果你的业务场景里，新数据的读写特别多特别频繁，那么建议一部分 data 节点的 role 角色是 hot。通常这些节点的服务器硬件配置是高性能 CPU、高内存以及使用高 IO 的固态硬盘，实现高吞吐量的数据读写。

本项目支持冷热数据规划，默认是最近 7 天的数据存储在 esHots 节点里。超过 7 天的数据会通过 curator 转移到冷数据节点。

## 「esWarms」ES 中负责存储冷数据的节点。

{{% notice info %}}
这里的英语名称使用了 warm 是遵循 ES 官方文章里的命名，实际上是没有严格限制节点 role 的命名方式。中文用“冷热”来写，读起来比较顺口罢了:)
{{% /notice %}}

```ini
# ElasticSearch warm data node(Optional). Normal Hard drive is OK.
# More settings in `group_vars/elasticDataNode.yml` file.
[esWarms]
es-warm-1 ansible_host=172.23.56.121
es-warm-2 ansible_host=172.23.56.122
es-warm-3 ansible_host=172.23.56.123
```

和 esHots 有所不同，这个组的服务器可以是低性能 CPU、小内存和大容量机械硬盘。用于存储查询频率低，但需要长期保留的数据。

## 「Logstash」日志二次流处理

```ini
# Logstash
# IMPORTANT: At least 1 node, DO NOT run with any ElasticSearch node on the same host.
[logstash]
logstash-1 ansible_host=172.23.56.114
```

如果你使用了其它日志处理程序，可以不部署 Logstash，但我还是建议你部署 1 个。

{{% notice warning %}}
切记：
由于 Logstash 也是 Java 程序，并且要对日志做二次处理，消耗大量的系统资源，所以请尽量不要把它和 ES 部署在同一个服务器里。除非你这些服务器拥有强劲的硬件配置。
{{% /notice %}}

## 「Kibana」你的数据可视化 UI

```ini
# Kibana
# IMPORTANT: At least 1 node, and will be install an ElasticSearch instance with 'Cross Cluster Search' settings.
# Read more on https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-cross-cluster-search.html#cross-cluster-search-settings
[kibana]
kibana-1 ansible_host=172.23.56.115
```

如果你更喜欢 Grafana，可以不安装它。我个人是十分喜欢使用 Kibana 的。

## 「Redis」高并发日志的缓冲池。

```ini
# Redis Cluster
# IMPORTANT: At least 3 nodes. DO NOT deploy with ElasticSearch hosts!
# This is an option groups. If it's empty, beats will send logs to logstash directly.
[redis]
redis-1 ansible_host=172.23.56.215
redis-2 ansible_host=172.23.56.216
redis-3 ansible_host=172.23.56.217
```

如果你的日志并发量非常大，你可以建立一个 Redis 集群作为缓存。客户端先把日志写入 redis 里，由 Logstash 去读取，处理后发送到 ES 集群里。

{{% notice info %}}
本项目的 Redis 集群采取 1 主 2 从的高可用架构，由 redis-sentinel 来监控。外部可以通过 haproxy 代理访问，参考 [HAProxy Advanced Redis Health Check](https://www.haproxy.com/blog/haproxy-advanced-redis-health-check/)。
{{% /notice %}}

## 配置你的 ssh 访问信息。

```ini

[all:vars]
ansible_user=username
ansible_ssh_pass=password
ansible_sudo_pass=password
```

{{% notice warning %}}
在 hosts.ini 里写入明文的账号密码是危险的。你应该使用秘钥方式访问，以及使用 [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) 来加密你的敏感数据。
{{% /notice %}}
