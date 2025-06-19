## 2022年1月11日

常规变更：

* 将 TiDB Operator 升级到 [v1.2.6](https://docs.pingcap.com/tidb-in-kubernetes/stable/release-1.2.6)。

改进：

* 在 [**连接**](/tidb-cloud/connect-via-standard-connection.md) 页面上的 MySQL 客户端添加建议选项 `--connect-timeout 15`。

Bug 修复：

* 修复了密码包含单引号时用户无法创建集群的问题。
* 修复了即使一个组织只有一个所有者，所有者也可以被删除或更改为其他角色的问题。