## 2024年11月12日

**常规变更**

- 为 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群添加暂停时长限制。

    TiDB Cloud Dedicated 现在限制最大暂停时长为 7 天。如果您未在 7 天内手动恢复集群，TiDB Cloud 将自动恢复它。

    此更改仅适用于**2024 年 11 月 12 日之后创建的组织**。在此日期或之前创建的组织将逐步过渡到新的暂停行为，并会事先收到通知。

    有关更多信息，请参阅 [暂停或恢复 TiDB Cloud Dedicated 集群](/tidb-cloud/pause-or-resume-tidb-cluster.md)。

- [Datadog 集成（beta）](/tidb-cloud/monitor-datadog-integration.md) 增加了对新区域的支持：`AP1`（日本）。

- 支持 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的一个新的 AWS 区域：`孟买 (ap-south-1)`。

- 移除对 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 AWS `圣保罗 (sa-east-1)` 区域的支持。