---
title: "编写理念"
weight: 31
chapter: true
pre: "<b>3.1 </b>"
---

### 了解各目录与 Playbook 的关系

# 我的 ansible 编写理念

## ansible 的概念比喻：

1. playbook:       总剧本
2. roles:          演员
3. inventory:      舞台
4. tasks:          分剧本
4. vars/templates: 道具

因此，每次执行一个 playbook，就是要求 roles（演员）去到指定的舞台（inventory），使用 vars/templates 道具，表演一个个的 tasks（分剧本）。

## ansible.cfg

在项目根目录下有个 ansible.cfg 文件，执行 ansible 命令时会优先读取这个文件里的配置。我根据一些经验做了优化。

```ini
[defaults]
inventory                 = hosts.ini
host_key_checking         = false
retry_files_enabled       = false
timeout                   = 60
gathering                 = smart
callback_whitelist        = profile_roles
stdout_callback           = skippy
remote_tmp                = $HOME/.ansible/tmp
no_target_syslog          = true

[paramiko_connection]
record_host_keys          = false

[ssh_connection]
ssh_args                  = -o ControlMaster=auto -o ConnectionAttempts=100 -o UserKnownHostsFile=/dev/null
pipelining                = true
```

## 一个 playbook 的组成

例如我们即将先执行的 01-init.yml 剧本。它是由以下部分组成：

{{<mermaid align="left">}}
graph LR;
    Playbook(01-env_init.yml)
    role[角色 roles/init] --> Playbook
    hosts[目标主机 hosts.ini] --> Playbook
    template[模板文件 templates/init] --> Playbook
    var1[角色变量 vars/sysctl_rules.yml] --> Playbook
    var2[全局变量 groups_vars/all.yml] --> Playbook
{{< /mermaid >}}

所有 roles 的 templates 目录，都存放在根目录下的 templates 里，在你需要修改时，不需要深入到具体的 role 里面去修改了。

同样的，roles 所需要的变量，也存放在根目录下的 vars 目录里。
