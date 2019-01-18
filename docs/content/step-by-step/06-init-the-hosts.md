---
title: "初始化系统环境"
weight: 36
chapter: true
pre: "<b>3.6 </b>"
---

## 初始化系统环境

playbook 的组成

{{<mermaid align="left">}}
graph LR;
    Playbook(01-env_init.yml)
    role[roles/init]-- role --> Playbook
    template[templates/init/]-- templates --> Playbook
    var1[vars/sysctl_rules.yml]-- vars --> Playbook
    var2[vars/download_urls.yml] -- vars --> Playbook
{{< /mermaid >}}

执行

```bash
$ ansible-playbook 01-env_init.yml
```

这个 playbook 大概做了以下事情

1. 检查 Python。主要是针对 Ubuntu Server 16.04 默认只有 Python3 的问题，在 host_vars 目录下会生成以 {{ inventory_hostname }}.yml 命名的文件，指定 `ansible_python_interpreter` 的 value。
2. 从 `vars/sysctl_rules.yml` 里读取 sysctl 配置，写入 `/etc/sysctl.conf` 里。
3. 把 {{ inventory_hostname }} 设为目标机系统的 hostname，以及 rsyslog 的主机名。例如 es-master-01。
4. elasticsearch 和 logstash 主机组安装 java。
5. 禁用 SELinux 和 firewalld（CentOS）。
6. 配置网卡的 DNS 信息。
7. 部署和配置 chrony 时间同步服务。
8. ES 主机组禁用 Swap 分区。
