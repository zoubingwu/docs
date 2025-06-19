## 2022年8月30日

**常规变更**

* 支持 AWS PrivateLink 驱动的终端节点连接，作为 TiDB Cloud [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的一种新的网络访问管理选项。

    终端节点连接是安全且私密的，不会将您的数据暴露给公共互联网。此外，终端节点连接支持 CIDR 重叠，并且更易于网络管理。

    有关更多信息，请参阅 [设置私有终端节点连接](/tidb-cloud/set-up-private-endpoint-connections.md)。

**控制台变更**

* 在 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [连接](/tidb-cloud/connect-to-tidb-cluster.md) 对话框的 **VPC 对等连接** 选项卡和 **私有终端节点** 选项卡中，提供 MySQL、MyCLI、JDBC、Python、Go 和 Node.js 的示例连接字符串。

    您只需将连接代码复制并粘贴到您的应用程序中，即可轻松连接到您的专用层集群。