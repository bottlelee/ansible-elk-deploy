---
title: "下载安装包"
weight: 35
chapter: true
pre: "<b>3.5 </b>"
---

## 下载安装包

首先我们把部署过程中需要安装的软件包都下载到本地。

playbook 的组成

{{<mermaid align="left">}}
graph LR;
  Playbook(00-download_files.yml)
  var1[vars/download_urls.yml] --> Playbook
{{< /mermaid >}}

执行

```bash
$ ansible-playbook 00-download_files.yml
What type of files do you need?[rpm|deb] [rpm]:
```

这里会问你需要下载什么格式的包，CentOS 系统的就是 rpm，Ubuntu 系统就是 deb。输入你想要的格式，回车就开始下载了。

所有下载的包都存放在 downloaded_files 目录下。大概需要 1GB 的存储空间。

这个 playbook 其实是导入相关 roles 的 download.yml，执行下载任务。

{{% notice tip %}}
这一步尤其适合，目标环境是离线不可访问互联网的场景。你只需在控制机里提前下载好需要的安装包，然后接入部署环境的网络即可。

如果某些下载链接无效了，请修改 `vars/download_urls.yml` 里的相关变量。yml 文件里已经有注释，标明下载的来源页。
{{% /notice %}}
