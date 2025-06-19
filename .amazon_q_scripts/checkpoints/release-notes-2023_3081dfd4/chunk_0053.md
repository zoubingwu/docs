## 2023年1月4日

**常规变更**

- 支持通过增加在 AWS 上托管且在 2022 年 12 月 31 日之后创建的 TiDB Cloud Dedicated 集群的 **节点大小（vCPU + RAM）** 来扩展 TiDB、TiKV 和 TiFlash 节点。

    您可以使用 [TiDB Cloud 控制台](/tidb-cloud/scale-tidb-cluster.md#change-vcpu-and-ram) 或 [TiDB Cloud API (beta)](https://docs.pingcap.com/tidbcloud/api/v1beta#tag/Cluster/operation/UpdateCluster) 来增加节点大小。

- 将 [**监控**](/tidb-cloud/built-in-monitoring.md) 页面上的指标保留期限延长至两天。

    现在您可以访问过去两天的指标数据，从而更灵活地了解集群性能和趋势。

    此改进无需额外费用，可以在集群的 [**监控**](/tidb-cloud/built-in-monitoring.md) 页面的 **诊断** 选项卡上访问。 这将帮助您识别和排除性能问题，并更有效地监控集群的整体健康状况。

- 支持为 Prometheus 集成自定义 Grafana 仪表板 JSON。

    如果您已将 [TiDB Cloud 与 Prometheus 集成](/tidb-cloud/monitor-prometheus-and-grafana-integration.md)，您现在可以导入预构建的 Grafana 仪表板来监控 TiDB Cloud 集群，并根据您的需要自定义仪表板。 此功能可以轻松快速地监控您的 TiDB Cloud 集群，并帮助您快速识别任何性能问题。

    有关更多信息，请参阅 [使用 Grafana GUI 仪表板可视化指标](/tidb-cloud/monitor-prometheus-and-grafana-integration.md#step-3-use-grafana-gui-dashboards-to-visualize-the-metrics)。

- 将所有 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的默认 TiDB 版本从 [v6.3.0](https://docs.pingcap.com/tidb/v6.3/release-6.3.0) 升级到 [v6.4.0](https://docs.pingcap.com/tidb/v6.4/release-6.4.0)。 将 Serverless Tier 集群的默认 TiDB 版本升级到 v6.4.0 后，冷启动问题已得到解决。

**控制台变更**

- 简化 [**集群**](https://tidbcloud.com/project/clusters) 页面和集群概览页面的显示。

    - 您可以单击 [**集群**](https://tidbcloud.com/project/clusters) 页面上的集群名称以进入集群概览页面并开始操作集群。
    - 从集群概览页面中删除 **连接** 和 **导入** 窗格。 您可以单击右上角的 **连接** 以获取连接信息，然后单击左侧导航窗格中的 **导入** 以导入数据。