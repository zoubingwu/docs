## 2024年12月3日

**通用变更**

- 推出恢复组功能（beta），用于在 AWS 上部署的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的灾难恢复。

    此功能使您能够在 TiDB Cloud Dedicated 集群之间复制数据库，从而确保在发生区域性灾难时能够快速恢复。如果您是项目所有者角色，则可以通过创建新的恢复组并将数据库分配给该组来启用此功能。通过使用恢复组复制数据库，您可以提高灾难准备能力，满足更严格的可用性 SLA，并实现更积极的恢复点目标 (RPO) 和恢复时间目标 (RTO)。

    有关更多信息，请参阅 [恢复组入门](/tidb-cloud/recovery-group-get-started.md)。