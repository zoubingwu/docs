## 2023年2月28日

**常规变更**

- 为[Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)集群添加[SQL诊断](/tidb-cloud/tune-performance.md)功能。

    通过SQL诊断，您可以深入了解与SQL相关的运行时状态，从而更有效地进行SQL性能调优。目前，Serverless Tier的SQL诊断功能仅提供慢查询数据。

    要使用SQL诊断，请单击Serverless Tier集群页面左侧导航栏上的**SQL诊断**。

**控制台变更**

- 优化左侧导航。

    您可以更高效地浏览页面，例如：

    - 您可以将鼠标悬停在左上角以快速切换集群或项目。
    - 您可以在**集群**页面和**管理**页面之间切换。

**API变更**

- 发布了多个用于数据导入的TiDB Cloud API端点：

    - 列出所有导入任务
    - 获取导入任务
    - 创建导入任务
    - 更新导入任务
    - 上传导入任务的本地文件
    - 在启动导入任务之前预览数据
    - 获取导入任务的角色信息

  有关更多信息，请参阅[API文档](https://docs.pingcap.com/tidbcloud/api/v1beta#tag/Import)。