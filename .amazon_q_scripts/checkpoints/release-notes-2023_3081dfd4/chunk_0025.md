## 2023年6月13日

**常规变更**

- 支持使用变更流将数据流式传输到 Amazon S3。

    这实现了 TiDB Cloud 和 Amazon S3 之间的无缝集成。它允许从 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群进行实时数据捕获和复制到 Amazon S3，确保下游应用程序和分析可以访问最新的数据。

    更多信息，请参见 [Sink to cloud storage](/tidb-cloud/changefeed-sink-to-cloud-storage.md)。

- 将 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 16 vCPU TiKV 的最大节点存储从 4 TiB 增加到 6 TiB。

    此增强功能增加了 TiDB Cloud Dedicated 集群的数据存储容量，提高了工作负载扩展效率，并满足了不断增长的数据需求。

    更多信息，请参见 [Size your cluster](/tidb-cloud/size-your-cluster.md)。

- 将 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的[监控指标保留期](/tidb-cloud/built-in-monitoring.md#metrics-retention-policy) 从 3 天延长至 7 天。

    通过延长指标保留期，您现在可以访问更多历史数据。 这有助于您识别集群的趋势和模式，从而做出更好的决策并更快地进行故障排除。

**控制台变更**

- 为 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [**Key Visualizer**](/tidb-cloud/tune-performance.md#key-visualizer) 页面发布新的原生 Web 基础设施。

    借助新的基础设施，您可以轻松浏览 **Key Visualizer** 页面，并以更直观和高效的方式访问必要的信息。 新的基础设施还解决了 UX 上的许多问题，使 SQL 诊断过程更加用户友好。