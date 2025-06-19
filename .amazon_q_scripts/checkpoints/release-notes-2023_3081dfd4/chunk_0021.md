## 2023年7月11日

**常规变更**

- [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 现已正式发布 (Generally Available)。

- 推出 TiDB Bot (beta)，这是一个由 OpenAI 提供支持的聊天机器人，提供多语言支持、24/7 实时响应和集成的文档访问。

    TiDB Bot 为您提供以下好处：

    - 持续支持：始终可用以协助和回答您的问题，从而增强支持体验。
    - 提高效率：自动响应减少延迟，从而提高整体运营效率。
    - 无缝文档访问：直接访问 TiDB Cloud 文档，以便轻松检索信息和快速解决问题。

  要使用 TiDB Bot，请单击 [TiDB Cloud 控制台](https://tidbcloud.com) 右下角的 **?**，然后选择 **Ask TiDB Bot** 开始聊天。

- 支持 [分支功能 (beta)](/tidb-cloud/branch-overview.md)，适用于 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群。

    TiDB Cloud 允许您为 TiDB Cloud Serverless 集群创建分支。集群的分支是一个独立的实例，其中包含来自原始集群的数据的分叉副本。它提供了一个隔离的环境，允许您连接到它并自由地进行实验，而不必担心影响原始集群。

    您可以使用 [TiDB Cloud 控制台](/tidb-cloud/branch-manage.md) 或 [TiDB Cloud CLI](/tidb-cloud/ticloud-branch-create.md) 为 2023 年 7 月 5 日之后创建的 TiDB Cloud Serverless 集群创建分支。

    如果您使用 GitHub 进行应用程序开发，则可以将 TiDB Cloud Serverless 分支集成到您的 GitHub CI/CD 管道中，这使您可以自动使用分支测试您的拉取请求，而不会影响生产数据库。有关更多信息，请参见 [将 TiDB Cloud Serverless 分支（Beta）与 GitHub 集成](/tidb-cloud/branch-github-integration.md)。

- 支持 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的每周备份。有关更多信息，请参见 [备份和恢复 TiDB Cloud Dedicated 数据](/tidb-cloud/backup-and-restore.md#turn-on-auto-backup)。