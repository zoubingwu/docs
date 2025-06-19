## 2023 年 3 月 28 日

**常规变更**

- 为 [changefeeds](/tidb-cloud/changefeed-overview.md) 添加 2 RCUs、4 RCUs 和 8 RCUs 规格，并支持在 [创建 changefeed](/tidb-cloud/changefeed-overview.md#create-a-changefeed) 时选择所需的规格。

    与之前需要 16 RCUs 的场景相比，使用这些新规格，数据复制成本最多可降低 87.5%。

- 支持扩展或缩小 2023 年 3 月 28 日之后创建的 [changefeeds](/tidb-cloud/changefeed-overview.md) 的规格。

    您可以通过选择更高的规格来提高复制性能，或通过选择更低的规格来降低复制成本。

    有关更多信息，请参阅 [缩放 changefeed](/tidb-cloud/changefeed-overview.md#scale-a-changefeed)。

- 支持将 AWS 中 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群中的增量数据实时复制到同一项目和同一区域中的 [无服务器层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群。

    有关更多信息，请参阅 [Sink to TiDB Cloud](/tidb-cloud/changefeed-sink-to-tidb-cloud.md)。

- 为 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [数据迁移](/tidb-cloud/migrate-from-mysql-using-data-migration.md) 功能支持两个新的 GCP 区域：`Singapore (asia-southeast1)` 和 `Oregon (us-west1)`。

    有了这些新区域，您可以有更多选择将数据迁移到 TiDB Cloud。如果您的上游数据存储在这些区域中或附近，您现在可以利用从 GCP 到 TiDB Cloud 更快、更可靠的数据迁移。

    有关更多信息，请参阅 [使用数据迁移将 MySQL 兼容数据库迁移到 TiDB Cloud](/tidb-cloud/migrate-from-mysql-using-data-migration.md)。

**控制台变更**

- 为 [无服务器层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的 [慢查询](/tidb-cloud/tune-performance.md#slow-query) 页面发布新的原生 Web 基础设施。

    借助这种新的基础设施，您可以轻松地浏览 [慢查询](/tidb-cloud/tune-performance.md#slow-query) 页面，并以更直观、更高效的方式访问必要的信息。 新的基础设施还解决了 UX 上的许多问题，使 SQL 诊断过程更加用户友好。