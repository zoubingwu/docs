## 2022年3月15日

常规变更：

* 不再有固定集群大小的集群层级。您可以轻松自定义 TiDB、TiKV 和 TiFlash 的[集群大小](/tidb-cloud/size-your-cluster.md)。
* 支持为没有 TiFlash 的现有集群添加 [TiFlash](/tiflash/tiflash-overview.md) 节点。
* 支持在[创建新集群](/tidb-cloud/create-tidb-cluster.md)时指定存储大小（500 到 2048 GiB）。集群创建后，存储大小无法更改。
* 引入一个新的公共区域：`eu-central-1`。
* 弃用 8 vCPU TiFlash，并提供 16 vCPU TiFlash。
* 分离 CPU 和存储的价格（两者都有 30% 的公开预览折扣）。
* 更新[计费信息](/tidb-cloud/tidb-cloud-billing.md)和[价格表](https://www.pingcap.com/pricing/)。

新功能：

* 支持 [Prometheus 和 Grafana 集成](/tidb-cloud/monitor-prometheus-and-grafana-integration.md)。

    通过 Prometheus 和 Grafana 集成，您可以配置一个 [Prometheus](https://prometheus.io/) 服务来从 TiDB Cloud 端点读取关键指标，并使用 [Grafana](https://grafana.com/) 查看这些指标。

* 支持根据新集群的所选区域分配默认备份时间。

    有关更多信息，请参阅[备份和恢复 TiDB 集群数据](/tidb-cloud/backup-and-restore.md)。