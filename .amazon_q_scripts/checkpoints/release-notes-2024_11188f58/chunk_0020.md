## 2024年6月4日

**通用变更**

- 推出恢复组功能（beta），用于在 AWS 上部署的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的灾难恢复。

    此功能使您能够在 TiDB Cloud Dedicated 集群之间复制数据库，从而确保在发生区域性灾难时快速恢复。如果您具有 `Project Owner` 角色，则可以通过创建新的恢复组并将数据库分配给该组来启用此功能。通过使用恢复组复制数据库，您可以提高灾难准备能力，满足更严格的可用性 SLA，并实现更积极的恢复点目标 (RPO) 和恢复时间目标 (RTO)。

    有关更多信息，请参阅 [恢复组入门](/tidb-cloud/recovery-group-get-started.md)。

- 推出 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 列式存储 [TiFlash](/tiflash/tiflash-overview.md) 的计费和计量（beta）。

    在 2024 年 6 月 30 日之前，TiDB Cloud Serverless 集群中的列式存储仍然免费，享受 100% 的折扣。在此日期之后，每个 TiDB Cloud Serverless 集群将包含 5 GiB 的免费列式存储配额。超出免费配额的使用将收费。

    有关更多信息，请参阅 [TiDB Cloud Serverless 定价详情](https://www.pingcap.com/tidb-serverless-pricing-details/#storage)。

- [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 支持 [生存时间 (TTL)](/time-to-live.md)。