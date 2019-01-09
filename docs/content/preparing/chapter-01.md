---
title: "准备控制机（Controller）"
chapter: true
---

# 控制机的环境准备

## 环境要求
1. Linux 桌面系统（推荐使用 Ubuntu）。
2. 可以访问互联网。

## 安装 ansible

#### 建立一个 shell 脚本。`nano /tmp/bootstrap-ansible.sh`，写入以下内容：<br>

```
#!/usr/bin/env bash

if [[ $USER != "root" ]]; then
  echo "Current user is not 'root'."
  echo "Run 'sudo -H $0'"
  exit 1
fi

cd /tmp

echo "Downloading https://bootstrap.pypa.io/get-pip.py"

wget -q https://bootstrap.pypa.io/get-pip.py -O get-pip.py || curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python /tmp/get-pip.py || python3 /tmp/get-pip.py

pip install -i https://pypi.doubanio.com/simple ansible

ansible --version
```

#### 执行安装脚本
```
bash /tmp/bootstrap-ansible.sh
```

#### 如果看到类似于以下信息的输出，表明 ansible 安装成功。
```
ansible 2.7.5
  config file = None
  configured module search path = [u'/home/haibin/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python2.7/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 2.7.15rc1 (default, Nov 12 2018, 14:31:15) [GCC 7.3.0]
```
