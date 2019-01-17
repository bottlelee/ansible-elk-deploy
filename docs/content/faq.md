---
title: "FAQ"
weight: 100
menu: ['main']
draft: false
---

## 磁盘扩容方式

#### 添加磁盘

添加新磁盘后，如果你没有使用 LVM/ZFS 之类的卷管理，可以按正常方式分区、格式化和挂载。然后在 elasticsearch.yml 里添加路径。例如：

```yaml
path.data:
  - /var/lib/elasticsearch
  - /var/lib/elasticsearch-1
```

重启 ES 后，ES 会自动做数据存储平衡。

#### 虚拟磁盘、LVM/ZFS

首先必须停止 ES 服务，然后按文件系统的官方文档说明进行扩容，再启动 ES 即可。
