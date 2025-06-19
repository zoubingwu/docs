> 语句摘要持久化是一项实验性功能。不建议在生产环境中使用。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：GLOBAL
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 此变量为只读。它指定启用[语句摘要持久化](/statement-summary-tables.md#persist-statements-summary)时可以持久化的最大数据文件数。

<CustomContent platform="tidb">

- 此变量的值与配置项 [`tidb_stmt_summary_file_max_backups`](/tidb-configuration-file.md#tidb_stmt_summary_file_max_backups-new-in-v660) 的值相同。

</CustomContent>

### tidb_stmt_summary_file_max_days <span class="version-mark">v6.6.0 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

> **警告：**
>
> 语句摘要持久化是一项实验性功能。不建议在生产环境中使用。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：GLOBAL
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`3`
- 单位：天
- 此变量为只读。它指定启用[语句摘要持久化](/statement-summary-tables.md#persist-statements-summary)时，持久数据文件保留的最长天数。

<CustomContent platform="tidb">

- 此变量的值与配置项 [`tidb_stmt_summary_file_max_days`](/tidb-configuration-file.md#tidb_stmt_summary_file_max_days-new-in-v660) 的值相同。

</CustomContent>

### tidb_stmt_summary_file_max_size <span class="version-mark">v6.6.0 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

> **警告：**
>
> 语句摘要持久化是一项实验性功能。不建议在生产环境中使用。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：GLOBAL
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`64`
- 单位：MiB
- 此变量为只读。它指定启用[语句摘要持久化](/statement-summary-tables.md#persist-statements-summary)时，持久数据文件的最大大小。

<CustomContent platform="tidb">

- 此变量的值与配置项 [`tidb_stmt_summary_file_max_size`](/tidb-configuration-file.md#tidb_stmt_summary_file_max_size-new-in-v660) 的值相同。

</CustomContent>

### tidb_stmt_summary_history_size <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`24`
- 范围：`[0, 255]`
- 此变量用于设置[语句摘要表](/statement-summary-tables.md)的历史容量。

### tidb_stmt_summary_internal_query <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于控制是否在[语句摘要表](/statement-summary-tables.md)中包含 TiDB 的 SQL 信息。

### tidb_stmt_summary_max_sql_length <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`4096`
- 范围：`[0, 2147483647]`
- 单位：字节

<CustomContent platform="tidb">

- 此变量用于控制[语句摘要表](/statement-summary-tables.md)和 [TiDB Dashboard](/dashboard/dashboard-intro.md) 中 SQL 字符串的长度。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于控制[语句摘要表](/statement-summary-tables.md) 中 SQL 字符串的长度。

</CustomContent>

### tidb_stmt_summary_max_stmt_count <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`3000`
- 范围：`[1, 32767]`
- 此变量用于限制 [`statements_summary`](/statement-summary-tables.md#statements_summary) 和 [`statements_summary_history`](/statement-summary-tables.md#statements_summary_history) 表可以在内存中总共存储的 SQL 摘要的数量。

<CustomContent platform="tidb">

> **注意：**
>
> 当启用 [`tidb_stmt_summary_enable_persistent`](/statement-summary-tables.md#persist-statements-summary) 时，`tidb_stmt_summary_max_stmt_count` 仅限制 [`statements_summary`](/statement-summary-tables.md#statements_summary) 表可以在内存中存储的 SQL 摘要的数量。

</CustomContent>

### tidb_stmt_summary_refresh_interval <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1800`
- 范围：`[1, 2147483647]`
- 单位：秒
- 此变量用于设置[语句摘要表](/statement-summary-tables.md)的刷新时间。

### tidb_store_batch_size

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`4`
- 范围：`[0, 25000]`
- 此变量用于控制 `IndexLookUp` 算子的 Coprocessor Tasks 的批量大小。 `0` 表示禁用批量处理。当任务数量相对较大且出现慢查询时，您可以增加此变量以优化查询。

### tidb_store_limit <span class="version-mark">v3.0.4 和 v4.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 9223372036854775807]`
- 此变量用于限制 TiDB 可以同时发送到 TiKV 的最大请求数。 0 表示没有限制。

### tidb_streamagg_concurrency

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1`
- 此变量设置查询执行时 `StreamAgg` 算子的并发度。
- **不建议**设置此变量。修改变量值可能会导致数据正确性问题。

### tidb_super_read_only <span class="version-mark">v5.3.1 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是