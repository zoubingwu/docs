## 2024年4月2日

**通用变更**

- 为 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群引入两种服务计划：**免费** 和 **可扩展**。

    为了满足不同的用户需求，TiDB Cloud Serverless 提供免费和可扩展的服务计划。无论您是刚开始使用还是扩展以满足不断增长的应用程序需求，这些计划都能提供您需要的灵活性和功能。

    更多信息，请参阅 [集群计划](/tidb-cloud/select-cluster-tier.md#cluster-plans)。

- 修改 TiDB Cloud Serverless 集群达到其使用配额时的限流行为。现在，一旦集群达到其使用配额，它会立即拒绝任何新的连接尝试，从而确保现有操作的不间断服务。

    更多信息，请参阅 [使用配额](/tidb-cloud/serverless-limitations.md#usage-quota)。