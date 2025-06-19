## 2023年2月14日

**常规变更**

- 支持减少 TiKV 和 TiFlash 节点数量，以在 TiDB [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群中进行缩容。

    您可以通过 [TiDB Cloud 控制台](/tidb-cloud/scale-tidb-cluster.md#change-node-number) 或 [通过 TiDB Cloud API (beta)](https://docs.pingcap.com/tidbcloud/api/v1beta#tag/Cluster/operation/UpdateCluster) 减少节点数量。

**控制台变更**

- 为 [Serverless 层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群引入 **监控** 页面。

    **监控** 页面提供了一系列指标和数据，例如每秒执行的 SQL 语句数量、查询的平均持续时间以及失败的查询数量，这有助于您更好地了解 Serverless 层集群中 SQL 语句的整体性能。

    有关更多信息，请参阅 [TiDB Cloud 内置监控](/tidb-cloud/built-in-monitoring.md)。