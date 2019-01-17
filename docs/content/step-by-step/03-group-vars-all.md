---
title: "设置全局变量"
weight: 34
chapter: true
pre: "<b>3.4 </b>"
---

### 设置全局变量

# 一些关键的配置

## 修改 group_vars/all.yml

根据你的实际环境，修改以下相关值。**未列出来的键值不需要做任何修改**。

| 键                  |    默认/建议值     | 说明                                                                                                          | 相关链接                             |
| ------------------- |:------------------:| ------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| elk_version         |       6.5.4        | ELK 版本号，具体可以上官网查询。                                                                              | https://www.elastic.co/downloads     |
| timezone            |   Asia/Shanghai    | 服务器的时区设置                                                                                              |                                      |
| apt_mirror          | mirrors.aliyun.com | 如果是使用 Ubuntu Server 系统，使用 aliyun 的源会比较快                                                       | https://opsx.alibaba.com/mirror      |
| searchguard_enabled |        true        | 启用 Search Guard 安全增强组件                                                                                | https://search-guard.com/            |
| bind_interface      |        eth1        | 如果你的服务器具有多张网卡，可以指定服务的监听 IP。如果留空，就使用 {{ ansible_default_ipv4.address }} 的值。 |                                      |
| dns_servers         |     127.0.0.1      | 必须保证 127.0.0.1 是第 1 个 DNS 解析服务地址。次要 DNS 解析 IP 可以自定义。                                  |                                      |
| consul_version      |       1.4.0        | 自服务发现注册，请到官网查看最新版本号。                                                                      | https://www.consul.io/downloads.html |
| consul_dc_name      |        elk         | Consul 的 Data Center 名称。                                                                                  |                                      |
| monit_version       |       5.25.2       | Monit 监控工具的版本号。                                                                                      | https://mmonit.com/monit/            |
| smtp_host           |         无         | 发送告警邮件的服务器地址。                                                                                    |                                      |
| smtp_user           |         无         | smtp 登录账号                                                                                                 |                                      |
| smtp_pass           |         无         | smtp 登录密码                                                                                                 |                                      |
| recipients          |         无         | 接收告警邮件的邮箱                                                                                            |                                      |
| redis_version       |       4.0.9        | redis 版本                                                                                                    |                                      |
