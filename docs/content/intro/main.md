---
title: "项目介绍"
date: 2019-01-07T14:57:31+08:00
draft: false
---

本项目使用 [Ansible](https://www.ansible.com/) 作为自动化工具，实现“一键部署” [ELK](https://www.elastic.co/)（Elastic Search + Logstash + Kibana）集群。

[Search Guard](https://search-guard.com/) 作为可选项，可以让你的 ELK 集群拥有一个可用的账户体系，实现一系列的权限分配。


{{% block note %}}
注意：本项目不支持单机部署。
{{% /block %}}