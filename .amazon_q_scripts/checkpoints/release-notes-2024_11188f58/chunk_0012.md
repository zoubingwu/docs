## 2024年9月3日

**控制台变更**

- 支持使用 [TiDB Cloud 控制台](https://tidbcloud.com/) 从 TiDB Cloud Serverless 集群导出数据。

    此前，TiDB Cloud 仅支持使用 [TiDB Cloud CLI](/tidb-cloud/cli-reference.md) 导出数据。现在，您可以轻松地将 TiDB Cloud Serverless 集群中的数据导出到本地文件和 Amazon S3，通过 [TiDB Cloud 控制台](https://tidbcloud.com/)。

    有关更多信息，请参阅 [从 TiDB Cloud Serverless 导出数据](/tidb-cloud/serverless-export.md) 和 [为 TiDB Cloud Serverless 配置外部存储访问](/tidb-cloud/serverless-external-storage.md)。

- 增强 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的连接体验。

    - 修改 **连接** 对话框界面，为 TiDB Cloud Dedicated 用户提供更精简高效的连接体验。
    - 引入新的集群级别 **网络** 页面，以简化集群的网络配置。
    - 将 **安全设置** 页面替换为新的 **密码设置** 页面，并将 IP 访问列表设置移至新的 **网络** 页面。

  有关更多信息，请参阅 [连接到 TiDB Cloud Dedicated](/tidb-cloud/connect-to-tidb-cluster.md)。

- 增强 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 和 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的数据导入体验：

    - 使用更清晰的布局优化 **导入** 页面的布局。
    - 统一 TiDB Cloud Serverless 和 TiDB Cloud Dedicated 集群的导入步骤。
    - 简化 AWS Role ARN 创建过程，以便更轻松地进行连接设置。

  有关更多信息，请参阅 [从文件导入数据到 TiDB Cloud](/tidb-cloud/tidb-cloud-migration-overview.md#import-data-from-files-to-tidb-cloud)。