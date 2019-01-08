---
title: "一键部署 ELK"
draft: false
---

### 一键部署
# ElasticSearch + Logstash + Kibana

本项目使用 [Ansible](https://www.ansible.com/) 作为自动化部署工具，实现“一键部署” [ELK](https://www.elastic.co/)（Elastic Search + Logstash + Kibana）生产集群。

## 项目特性

* 集成 Consul 服务自发现自注册，服务之间通过 DNS 访问，实现 ELK 各组件可水平扩缩而无需更改配以及重启。
* ES 可以划分多种角色，实现冷热数据等运维规划

## **环境准备**
* [文档说明](preparing)
* [Ansible](ansible)


## 关于我

擅长 Linux 运维的文科生
