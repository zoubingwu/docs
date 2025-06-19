## 2023年3月21日

**常规变更**

- 针对 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群，引入 [Data Service (beta)](https://tidbcloud.com/project/data-service)，使您能够通过使用自定义 API 端点的 HTTPS 请求来访问数据。

    借助 Data Service，您可以将 TiDB Cloud 与任何兼容 HTTPS 的应用程序或服务无缝集成。以下是一些常见场景：

    - 直接从移动或 Web 应用程序访问 TiDB 集群的数据库。
    - 使用 Serverless 边缘函数调用端点，避免数据库连接池导致的可扩展性问题。
    - 通过使用 Data Service 作为数据源，将 TiDB Cloud 与数据可视化项目集成。
    - 从 MySQL 接口不支持的环境连接到您的数据库。

    此外，TiDB Cloud 还提供 [Chat2Query API](/tidb-cloud/use-chat2query-api.md)，这是一个 RESTful 接口，允许您使用 AI 生成和执行 SQL 语句。

    要访问 Data Service，请导航到左侧导航窗格中的 [**Data Service**](https://tidbcloud.com/project/data-service) 页面。有关更多信息，请参阅以下文档：

    - [Data Service 概述](/tidb-cloud/data-service-overview.md)
    - [Data Service 入门](/tidb-cloud/data-service-get-started.md)
    - [Chat2Query API 入门](/tidb-cloud/use-chat2query-api.md)

- 支持减小 TiDB、TiKV 和 TiFlash 节点的大小，以在 AWS 上托管且在 2022 年 12 月 31 日之后创建的 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群中进行缩容。

    您可以[通过 TiDB Cloud 控制台](/tidb-cloud/scale-tidb-cluster.md#change-vcpu-and-ram)或[通过 TiDB Cloud API (beta)](https://docs.pingcap.com/tidbcloud/api/v1beta#tag/Cluster/operation/UpdateCluster) 减小节点大小。

- 为 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [Data Migration](/tidb-cloud/migrate-from-mysql-using-data-migration.md) 功能支持新的 GCP 区域：`Tokyo (asia-northeast1)`。

    该功能可以帮助您轻松高效地将 Google Cloud Platform (GCP) 中与 MySQL 兼容的数据库中的数据迁移到您的 TiDB 集群。

    有关更多信息，请参阅 [使用 Data Migration 将与 MySQL 兼容的数据库迁移到 TiDB Cloud](/tidb-cloud/migrate-from-mysql-using-data-migration.md)。

**控制台变更**

- 为 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群引入 **Events** 页面，该页面提供对集群的主要更改的记录。

    在此页面上，您可以查看过去 7 天的事件历史记录，并跟踪重要详细信息，例如触发时间和发起操作的用户。例如，您可以查看集群何时暂停或谁修改了集群大小等事件。

    有关更多信息，请参阅 [TiDB Cloud 集群事件](/tidb-cloud/tidb-cloud-events.md)。

- 将 **Database Status** 选项卡添加到 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的 **Monitoring** 页面，该页面显示以下数据库级别指标：

    - 每个数据库的 QPS
    - 每个数据库的平均查询持续时间
    - 每个数据库的失败查询

  通过这些指标，您可以监控各个数据库的性能，做出数据驱动的决策，并采取措施来提高应用程序的性能。

  有关更多信息，请参阅 [Serverless Tier 集群的监控指标](/tidb-cloud/built-in-monitoring.md)。