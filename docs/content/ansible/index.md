---
title: "Ansible"
date: 2019-01-08T15:18:28+08:00
draft: false
chapter: true
---

### 安装 python pip 和 ansible

1. 建立一个 shell 脚本。`nano /tmp/bootstrap-ansible.sh`，写入以下内容：

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
```

2. 执行 `bash /tmp/bootstrap-ansible.sh`
