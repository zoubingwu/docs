## 2023年4月11日

**常规变更**

- 提高 TiDB 的负载均衡，并减少在 AWS 上托管的 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群扩展 TiDB 节点时连接断开的情况。

    - 支持在横向扩展 TiDB 节点时，自动将现有连接迁移到新的 TiDB 节点。
    - 支持在横向缩减 TiDB 节点时，自动将现有连接迁移到可用的 TiDB 节点。

  目前，此功能仅适用于托管在 AWS `俄勒冈 (us-west-2)` 区域的专用层集群。

- 支持 [New Relic](https://newrelic.com/) 集成，用于 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群。

    通过 New Relic 集成，您可以配置 TiDB Cloud 将 TiDB 集群的指标数据发送到 [New Relic](https://newrelic.com/)。 然后，您可以在 [New Relic](https://newrelic.com/) 上监控和分析您的应用程序性能和 TiDB 数据库性能。 此功能可以帮助您快速识别和排除潜在问题，并缩短解决时间。

    有关集成步骤和可用指标，请参阅 [将 TiDB Cloud 与 New Relic 集成](/tidb-cloud/monitor-new-relic-integration.md)。

- 将以下 [changefeed](/tidb-cloud/changefeed-overview.md) 指标添加到专用层集群的 Prometheus 集成中。

    - `tidbcloud_changefeed_latency`
    - `tidbcloud_changefeed_replica_rows`

    如果您已 [将 TiDB Cloud 与 Prometheus 集成](/tidb-cloud/monitor-prometheus-and-grafana-integration.md)，则可以使用这些指标实时监控 changefeed 的性能和健康状况。 此外，您可以轻松创建警报以使用 Prometheus 监控指标。

**控制台变更**

- 更新 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [监控](/tidb-cloud/built-in-monitoring.md#view-the-metrics-page) 页面，以使用 [节点级资源指标](/tidb-cloud/built-in-monitoring.md#server)。

    通过节点级资源指标，您可以更准确地了解资源消耗情况，从而更好地了解所购买服务的实际使用情况。

    要访问这些指标，请导航到集群的 [监控](/tidb-cloud/built-in-monitoring.md#view-the-metrics-page) 页面，然后选中 **指标** 选项卡下的 **服务器** 类别。

- 通过重新组织 **按项目汇总** 和 **按服务汇总** 中的计费项目来优化 [计费](/tidb-cloud/tidb-cloud-billing.md#billing-details) 页面，这使得计费信息更加清晰。