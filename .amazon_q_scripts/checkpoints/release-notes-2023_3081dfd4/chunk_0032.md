## 2023年5月9日

**常规变更**

- 支持更改 2023 年 4 月 26 日之后创建的 GCP 托管集群的节点大小。

    借助此功能，您可以升级到更高性能的节点以满足更高的需求，或者降级到更低性能的节点以节省成本。 凭借这种增加的灵活性，您可以调整集群的容量以适应您的工作负载并优化成本。

    有关详细步骤，请参阅[更改节点大小](/tidb-cloud/scale-tidb-cluster.md#change-vcpu-and-ram)。

- 支持导入压缩文件。 您可以导入以下格式的 CSV 和 SQL 文件：`.gzip`、`.gz`、`.zstd`、`.zst` 和 `.snappy`。 此功能提供了一种更高效且经济高效的数据导入方式，并降低了您的数据传输成本。

    有关更多信息，请参阅[将 CSV 文件从云存储导入到 TiDB Cloud Dedicated](/tidb-cloud/import-csv-files.md)和[导入示例数据](/tidb-cloud/import-sample-data.md)。

- 支持基于 AWS PrivateLink 的端点连接，作为 TiDB Cloud [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的一种新的网络访问管理选项。

    私有端点连接不会将您的数据暴露给公共互联网。 此外，端点连接支持 CIDR 重叠，并且更易于网络管理。

    有关更多信息，请参阅[设置私有端点连接](/tidb-cloud/set-up-private-endpoint-connections.md)。

**控制台变更**

- 将新的事件类型添加到[**事件**](/tidb-cloud/tidb-cloud-events.md)页面，以记录 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的备份、恢复和变更数据捕获操作。

    要获取可以记录的事件的完整列表，请参阅[已记录的事件](/tidb-cloud/tidb-cloud-events.md#logged-events)。

- 在 [**SQL 诊断**](/tidb-cloud/tune-performance.md) 页面上为 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群引入 **SQL 语句** 选项卡。

    **SQL 语句** 选项卡提供以下内容：

    - 全面概述 TiDB 数据库执行的所有 SQL 语句，使您可以轻松识别和诊断慢查询。
    - 有关每个 SQL 语句的详细信息，例如查询时间、执行计划和数据库服务器响应，帮助您优化数据库性能。
    - 用户友好的界面，可以轻松地对大量数据进行排序、过滤和搜索，使您可以专注于最关键的查询。

  有关更多信息，请参阅[语句分析](/tidb-cloud/tune-performance.md#statement-analysis)。