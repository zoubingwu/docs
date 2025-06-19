## 2023年9月19日

**常规变更**

- 从 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群中移除 2 vCPU 的 TiDB 和 TiKV 节点。

    **创建集群**页面或**修改集群**页面不再提供 2 vCPU 选项。

- 发布适用于 JavaScript 的 [TiDB Cloud serverless driver (beta)](/tidb-cloud/serverless-driver.md)。

    适用于 JavaScript 的 TiDB Cloud serverless driver 允许您通过 HTTPS 连接到您的 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群。 它在 TCP 连接受限的边缘环境中特别有用，例如 [Vercel Edge Function](https://vercel.com/docs/functions/edge-functions) 和 [Cloudflare Workers](https://workers.cloudflare.com/)。

    有关更多信息，请参阅 [TiDB Cloud serverless driver (beta)](/tidb-cloud/serverless-driver.md)。

**控制台变更**

- 对于 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群，您可以在**本月用量**面板中或设置消费限额时获得成本估算。