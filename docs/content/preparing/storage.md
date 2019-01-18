---
title: "目标机准备"
weight: 03
chapter: true
pre: "<b>1.2 </b>"
---

### ElasticSearch

# 磁盘规划

{{% notice info %}}
[ansible-elk-deploy](https://gitee.com/bottlelee/ansible-elk-deploy/) 已经根据官方文档建议，在部署过程中对 OS 做了针对优化。唯一不适合处理的是数据磁盘的规划，这个需要前期安装系统的同时做好规划。
{{% /notice %}}

{{% notice warning %}}
生产环境必须挂载独立的磁盘作为 ES 存储使用。
{{% /notice %}}

## 文件系统格式

EXT4 常见的 Linux 文件系统格式。如果是在大型生产环境，使用 ZFS 系统是比较好的选择。这里就不展开来说了，具体可以查阅相关文档。

## 磁盘容量预估

假设每条日志 0.1kb 大小，每秒产生 1000 条日志记录，不做任何解构的前提下，每天的数据存储量在 8.6GB 左右。2TB 磁盘空间可以存储 230 天左右的日志。

请根据你的实际业务，估算日志量。如果是使用云主机，那么直接挂载可以扩容的云硬盘即可。

{{% notice tip %}}
一般云存储都会有副本，所以 ES 的 indices 不需要 replica，只保存 primary 就可以了。这个在 ES 部署章节里会指出如何设置。
{{% /notice %}}

## 挂载路径

这个没有标准要求，只要你所有的 ES 数据存储路径都一致，这样就容易管理。然后你可以在 `vars/elasticsearch.yml` 里找到 `elastic_data_paths` 这个变量，修改或增加新的路径即可。后面关于部署 ES 的章节里会详细说明。
