## 2022年7月5日

* 列式存储 [TiFlash](/tiflash/tiflash-overview.md) 现已正式发布 (GA)。

    - TiFlash 使 TiDB 本质上成为混合事务/分析处理 (HTAP) 数据库。您的应用程序数据首先存储在 TiKV 中，然后通过 Raft 共识算法复制到 TiFlash。因此，它是从行存储到列存储的实时复制。
    - 对于具有 TiFlash 副本的表，TiDB 优化器会自动根据成本估算确定是使用 TiKV 还是 TiFlash 副本。

    要体验 TiFlash 带来的好处，请参阅 [TiDB Cloud HTAP 快速入门指南](/tidb-cloud/tidb-cloud-htap-quickstart.md)。

* 支持[增加 TiKV 和 TiFlash 的存储大小](/tidb-cloud/scale-tidb-cluster.md#change-storage)，适用于专用层集群。
* 支持在节点大小字段中显示内存信息。