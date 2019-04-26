---
title: "安装 Kibana"
weight: 39
chapter: true
pre: "<b>3.9 </b>"
---

### 数据可视化 UI

# Kibana

**如果你不需要 Kibana，可以跳过这一步。**

内部 Consul 域名是 `kibana.service.{{ consul_dc_name }}.consul`

#### playbook 的组成

{{<mermaid align="left">}}
graph LR;
  Playbook(04-deploy_kibana.yml)
  role[roles/deploy.Kibana] --> Playbook
  template[templates/kibana/] --> Playbook
  var1[group_vars/all.yml] --> Playbook
  var2[vars/curator.yml] --> Playbook
  var3[vars/elasticsearch.yml] --> Playbook
  var4[vars/search_guard.yml] --> Playbook
  var5[vars/search_guard_auth.yml] --> Playbook
{{< /mermaid >}}

#### 执行

```bash
$ ansible-playbook 04-deploy_kibana.yml
```

{{% notice info %}}
如果选择了启用 Search Guard，Kibana 的第一次启动会有个 nodejs 的优化动作，这个过程可能会持续十几分钟，而且会占用大量内存。如果你同时有 ES 部署在这些机器上，可能会造成 OOM。出现这种情况时，可以延迟 30 分钟左右，再执行一次 ES 的 playbook 就好了。
{{% /notice %}}

{{% notice tip %}}
你可以部署多个 Kibana，在集群之外部署一个 Nignx 或 HAProxy 做负载均衡反向代理即可。本文档不展开说明。
{{% /notice %}}

#### 访问

\<IP\>:5601
