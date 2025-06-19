## 2023年6月6日

**常规变更**

- 为 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群引入 [Index Insight (beta)](/tidb-cloud/index-insight.md)，它通过为慢查询提供索引建议来优化查询性能。

    借助 Index Insight，您可以通过以下方式提高整体应用程序性能和数据库操作效率：

    - 增强的查询性能：Index Insight 识别慢查询并为其建议适当的索引，从而加快查询执行速度，缩短响应时间并改善用户体验。
    - 成本效益：通过使用 Index Insight 优化查询性能，可以减少对额外计算资源的需求，从而使您能够更有效地利用现有基础设施。 这可能会带来运营成本的节省。
    - 简化的优化过程：Index Insight 简化了索引改进的识别和实施，无需手动分析和猜测。 因此，您可以节省时间和精力，并获得准确的索引建议。
    - 提高应用程序效率：通过使用 Index Insight 优化数据库性能，在 TiDB Cloud 上运行的应用程序可以处理更大的工作负载并同时为更多用户提供服务，从而使应用程序的扩展操作更加高效。

  要使用 Index Insight，请导航到 TiDB Cloud Dedicated 集群的**诊断**页面，然后单击 **Index Insight BETA** 选项卡。

    有关更多信息，请参见 [使用 Index Insight (beta)](/tidb-cloud/index-insight.md)。

- 引入 [TiDB Playground](https://play.tidbcloud.com/?utm_source=docs&utm_medium=tidb_cloud_release_notes)，这是一个交互式平台，无需注册或安装即可体验 TiDB 的全部功能。

    TiDB Playground 是一个交互式平台，旨在为探索 TiDB 的功能（例如可伸缩性、MySQL 兼容性和实时分析）提供一站式体验。

    借助 TiDB Playground，您可以在受控环境中实时试用 TiDB 功能，而无需复杂的配置，这使其成为了解 TiDB 功能的理想选择。

    要开始使用 TiDB Playground，请转到 [**TiDB Playground**](https://play.tidbcloud.com/?utm_source=docs&utm_medium=tidb_cloud_release_notes) 页面，选择要探索的功能，然后开始您的探索。