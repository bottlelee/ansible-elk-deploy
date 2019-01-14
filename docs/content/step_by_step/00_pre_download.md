---
title: "编写理念"
weight: 31
chapter: true
---

### 了解各目录与 Playbook 的关系

# 留空

#### 举例说明

例如我们即将先执行的 01-init.yml 剧本。它是由以下部分组成

{{<mermaid align="left">}}
graph LR;
    Playbook(01-init.yml)
    var1[角色变量 vars/sysctl_rules.yml] --> Playbook
    var2[全局变量 groups_vars/all.yml] --> Playbook
    role[角色 roles/init] --> Playbook
    hosts[目标主机 hosts.ini] --> Playbook
{{< /mermaid >}}
