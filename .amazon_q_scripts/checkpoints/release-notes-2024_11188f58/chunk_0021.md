## 2024年5月28日

**常规变更**

- Google Cloud `台湾 (asia-east1)` 区域支持 [数据迁移](/tidb-cloud/migrate-from-mysql-using-data-migration.md) 功能。

    托管在 Google Cloud `台湾 (asia-east1)` 区域的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群现在支持数据迁移 (DM) 功能。如果您的上游数据存储在该区域或附近，您现在可以利用更快、更可靠的数据迁移，从 Google Cloud 迁移到 TiDB Cloud。

- 为托管在 AWS 和 Google Cloud 上的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群提供新的 [TiDB 节点大小](/tidb-cloud/size-your-cluster.md#tidb-vcpu-and-ram)：`16 vCPU, 64 GiB`

**API 变更**

- 引入 TiDB Cloud Data Service API，用于自动高效地管理以下资源：

    * **Data App (数据应用)**：一组端点，您可以使用这些端点来访问特定应用程序的数据。
    * **Data Source (数据源)**：链接到数据应用以进行数据操作和检索的集群。
    * **Endpoint (端点)**：一个 Web API，您可以自定义它来执行 SQL 语句。
    * **Data API Key (数据 API 密钥)**：用于安全地访问端点。
    * **OpenAPI Specification (OpenAPI 规范)**：Data Service 支持为每个数据应用生成 OpenAPI 规范 3.0，使您能够以标准化格式与您的端点进行交互。

  这些 TiDB Cloud Data Service API 端点在 TiDB Cloud API v1beta1 中发布，这是 TiDB Cloud 的最新 API 版本。

    有关更多信息，请参阅 [API 文档 (v1beta1)](https://docs.pingcap.com/tidbcloud/api/v1beta1/dataservice)。