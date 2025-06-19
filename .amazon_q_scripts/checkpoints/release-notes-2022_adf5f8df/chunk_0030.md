## 2022年7月26日

* 支持新的[开发者层集群](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)的自动休眠和恢复。

    开发者层集群在不活动 7 天后不会被删除，因此您可以在一年免费试用期结束前的任何时间使用它。 不活动 24 小时后，开发者层集群将自动休眠。 要恢复集群，请向集群发送新连接，或单击 TiDB Cloud 控制台中的**恢复**按钮。 集群将在 50 秒内恢复并自动恢复服务。

* 为新的[开发者层集群](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)添加用户名前缀限制。

    无论何时使用或设置数据库用户名，都必须在用户名中包含集群的前缀。 有关更多信息，请参见[用户名前缀](/tidb-cloud/select-cluster-tier.md#user-name-prefix)。

* 禁用[开发者层集群](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)的备份和恢复功能。

    开发者层集群禁用备份和恢复功能（包括自动备份和手动备份）。 您仍然可以使用 [Dumpling](https://docs.pingcap.com/tidb/stable/dumpling-overview) 导出数据作为备份。

* 将[开发者层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)集群的存储大小从 500 MiB 增加到 1 GiB。
* 向 TiDB Cloud 控制台添加面包屑导航，以改善导航体验。
* 支持在将数据导入 TiDB Cloud 时配置多个过滤规则。
* 从**项目设置**中删除**流量过滤器**页面，并从**连接到 TiDB** 对话框中删除**从默认集添加规则**按钮。