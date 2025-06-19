## 2022年9月27日

**常规变更**

* 支持通过邀请加入多个组织。

    在 TiDB Cloud 控制台中，您可以查看您已加入的所有组织并在它们之间切换。有关详细信息，请参阅[在组织之间切换](/tidb-cloud/manage-user-access.md#view-and-switch-between-organizations)。

* 添加用于 SQL 诊断的[慢查询](/tidb-cloud/tune-performance.md#slow-query)页面。

    在“慢查询”页面上，您可以搜索和查看 TiDB 集群中的所有慢查询，并通过查看其[执行计划](https://docs.pingcap.com/tidbcloud/explain-overview)、SQL 执行信息和其他详细信息来探索每个慢查询的瓶颈。

* 当您重置帐户密码时，TiDB Cloud 会根据您最近的四个密码检查您的新密码输入，并提醒您避免使用它们中的任何一个。不允许使用任何四个已使用的密码。

    有关详细信息，请参阅[密码验证](/tidb-cloud/tidb-cloud-password-authentication.md)。