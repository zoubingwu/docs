## 2022年9月15日

**常规变更**

* 支持通过 TLS 连接到 TiDB Cloud [专用层级](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群。

    对于专用层级集群，[连接](/tidb-cloud/connect-via-standard-connection.md)对话框中的**标准连接**选项卡现在提供了一个链接，用于下载 TiDB 集群 CA，并提供 TLS 连接的连接字符串和示例代码。 您可以使用第三方 MySQL 客户端、MyCLI 以及应用程序的多种连接方法（例如 JDBC、Python、Go 和 Node.js）[通过 TLS 连接到您的专用层级集群](/tidb-cloud/connect-via-standard-connection.md)。 此功能可确保从您的应用程序到 TiDB 集群的数据传输安全。