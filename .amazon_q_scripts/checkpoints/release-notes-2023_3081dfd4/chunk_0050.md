## 2023年1月17日

**常规变更**

- 将新 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v6.1.3](https://docs.pingcap.com/tidb/stable/release-6.1.3) 升级到 [v6.5.0](https://docs.pingcap.com/tidb/stable/release-6.5.0)。

- 对于新注册用户，TiDB Cloud 将自动创建一个免费的 [Serverless 层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群，以便您可以快速开始使用 TiDB Cloud 进行数据探索之旅。

- 为 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群支持一个新的 AWS 区域：`Seoul (ap-northeast-2)`。

    此区域启用了以下功能：

    - [使用数据迁移将 MySQL 兼容数据库迁移到 TiDB Cloud](/tidb-cloud/migrate-from-mysql-using-data-migration.md)
    - [使用变更数据捕获将数据从 TiDB Cloud 流式传输到其他数据服务](/tidb-cloud/changefeed-overview.md)
    - [备份和恢复 TiDB 集群数据](/tidb-cloud/backup-and-restore.md)