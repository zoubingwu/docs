## 2023年2月21日

**常规变更**

- 支持使用 IAM 用户的 AWS 访问密钥来访问您的 Amazon S3 存储桶，以便将数据导入到 TiDB Cloud。

    此方法比使用角色 ARN 更简单。有关更多信息，请参阅 [配置 Amazon S3 访问](/tidb-cloud/dedicated-external-storage.md#configure-amazon-s3-access)。

- 将 [监控指标保留期限](/tidb-cloud/built-in-monitoring.md#metrics-retention-policy) 从 2 天延长到更长的时间：

    - 对于专用层集群，您可以查看过去 7 天的指标数据。
    - 对于无服务器层集群，您可以查看过去 3 天的指标数据。

  通过延长指标保留期限，您现在可以访问更多历史数据。这有助于您识别集群的趋势和模式，从而更好地进行决策和更快地进行故障排除。

**控制台变更**

- 在 [无服务器层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的监控页面上发布新的原生 Web 基础设施。

    借助新的基础设施，您可以轻松浏览监控页面，并以更直观和高效的方式访问必要的信息。新的基础设施还解决了 UX 上的许多问题，使监控过程更加用户友好。