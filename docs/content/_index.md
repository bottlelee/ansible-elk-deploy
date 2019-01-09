---
title: "一键部署 ELK"
draft: false
---

### 一键部署
# ElasticSearch + Logstash + Kibana

本项目使用 [Ansible](https://www.ansible.com/) 作为自动化部署工具，实现“一键部署” [ELK](https://www.elastic.co/)（Elastic Search + Logstash + Kibana）生产集群。

## 项目特性

* 集成 [Consul](https://www.consul.io/) 服务发现注册。
* 集成 [Monit](https://mmonit.com/monit/) 监控，附带配套的 Kibana 看板。
* 集成 [Curator](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html) 对 indices 进行日常定时维护。
* ES 可以划分多种角色，实现冷热数据等运维规划。
* 包括升级脚本，可实现集群平滑版本升级。
* 离线部署方式，生产环境无需访问外网。

## **环境准备**
{{% children depth="3" %}}

## 关于我

喜欢折腾 Linux 运维的汉语言文学师范专科毕业生。
