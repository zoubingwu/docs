## 2022年12月27日

**常规变更**

- 将所有[Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)集群的默认 TiDB 版本从 [v6.3.0](https://docs-archive.pingcap.com/tidb/v6.3/release-6.3.0) 升级到 [v6.4.0](https://docs-archive.pingcap.com/tidb/v6.4/release-6.4.0)。

- Dedicated Tier 集群的时间点恢复 (PITR) 现在已正式发布 (GA)。

    PITR 支持将任何时间点的数据恢复到新集群。要使用 PITR 功能，请确保您的 TiDB 集群版本至少为 v6.4.0，并且 TiKV 节点大小至少为 8 vCPU 和 16 GiB。

    您可以在 [TiDB Cloud 控制台](https://tidbcloud.com)的**备份设置**中启用或禁用 PITR 功能。

    有关更多信息，请参阅[备份和恢复 TiDB 集群数据](/tidb-cloud/backup-and-restore.md)。

- 支持管理多个 Changefeed 并编辑现有 Changefeed。

    - 您现在可以根据需要创建任意数量的 Changefeed 来管理不同的数据复制任务。目前，每个集群最多可以有 10 个 Changefeed。有关更多详细信息，请参阅[Changefeed 概述](/tidb-cloud/changefeed-overview.md)。
    - 您可以编辑处于暂停状态的现有 Changefeed 的配置。有关更多信息，请参阅[编辑 Changefeed](/tidb-cloud/changefeed-overview.md#edit-a-changefeed)。

- 支持直接将数据从 Amazon Aurora MySQL、Amazon Relational Database Service (RDS) MySQL 或自托管的 MySQL 兼容数据库在线迁移到 TiDB Cloud。此功能现已正式发布。

    - 在以下 6 个区域提供服务：
        - AWS 俄勒冈 (us-west-2)
        - AWS 北弗吉尼亚 (us-east-1)
        - AWS 孟买 (ap-south-1)
        - AWS 新加坡 (ap-southeast-1)
        - AWS 东京 (ap-northeast-1)
        - AWS 法兰克福 (eu-central-1)
    - 支持多种规格。您可以根据所需的性能选择合适的规格，以获得最佳的数据迁移体验。

  有关如何将数据迁移到 TiDB Cloud，请参阅[用户文档](/tidb-cloud/migrate-from-mysql-using-data-migration.md)。有关计费详情，请参阅[数据迁移计费](/tidb-cloud/tidb-cloud-billing-dm.md)。

- 支持将本地 CSV 文件导入到 TiDB Cloud。

    只需点击几下即可完成任务配置，然后您的本地 CSV 数据就可以快速导入到您的 TiDB 集群中。使用此方法时，您无需提供云存储桶路径和 Role ARN。整个导入过程快速而流畅。

    有关更多信息，请参阅[将本地文件导入到 TiDB Cloud](/tidb-cloud/tidb-cloud-import-local-files.md)。