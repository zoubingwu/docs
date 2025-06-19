## 2022年9月6日

**通用变更**

* 将新[专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated)集群的默认 TiDB 版本从 [v6.1.0](https://docs.pingcap.com/tidb/stable/release-6.1.0) 升级到 [v6.1.1](https://docs.pingcap.com/tidb/stable/release-6.1.1)。

**控制台变更**

* 现在，您可以从 TiDB Cloud 控制台右上角的入口[申请 PoC](/tidb-cloud/tidb-cloud-poc.md)。

**API 变更**

* 支持通过 [TiDB Cloud API](/tidb-cloud/api-overview.md) 增加 TiKV 或 TiFlash 节点的存储。 您可以使用 API 端点的 `storage_size_gib` 字段进行扩容。

    目前，TiDB Cloud API 仍处于 Beta 阶段，仅应要求提供。

    有关详细信息，请参阅[修改专用层集群](https://docs.pingcap.com/tidbcloud/api/v1beta#tag/Cluster/operation/UpdateCluster)。