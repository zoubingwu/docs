- 验证 UTF-8 字符会影响性能。当您确定输入字符是有效的 UTF-8 字符时，可以将此变量值设置为 `ON`。

> **注意：**
>
> 如果跳过字符检查，TiDB 可能无法检测到应用程序写入的非法 UTF-8 字符，导致执行 `ANALYZE` 时出现解码错误，并引入其他未知的编码问题。如果您的应用程序无法保证写入字符串的有效性，则不建议跳过字符检查。

### tidb_slow_log_threshold

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`300`
- 范围：`[-1, 9223372036854775807]`
- 单位：毫秒
- 此变量输出慢日志消耗时间的阈值，默认设置为 300 毫秒。当查询消耗的时间大于此值时，此查询被认为是慢查询，其日志将输出到慢查询日志。请注意，当 [`log.level`](https://docs.pingcap.com/zh/tidb/v8.1/tidb-configuration-file#level) 的输出级别为 `"debug"` 时，所有查询都会记录在慢查询日志中，而与此变量的设置无关。

### tidb_slow_query_file

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 查询 `INFORMATION_SCHEMA.SLOW_QUERY` 时，只会解析配置文件中 `slow-query-file` 设置的慢查询日志名称。默认的慢查询日志名称是 "tidb-slow.log"。要解析其他日志，请将 `tidb_slow_query_file` 会话变量设置为特定的文件路径，然后查询 `INFORMATION_SCHEMA.SLOW_QUERY` 以基于设置的文件路径解析慢查询日志。

<CustomContent platform="tidb">

有关详细信息，请参阅[识别慢查询](/identify-slow-queries.md)。

</CustomContent>

### tidb_slow_txn_log_threshold <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Unsigned integer
- 默认值：`0`
- 范围：`[0, 9223372036854775807]`
- 单位：毫秒
- 此变量设置慢事务日志记录的阈值。当事务的执行时间超过此阈值时，TiDB 会记录有关该事务的详细信息。当该值设置为 `0` 时，此功能将被禁用。

### tidb_snapshot

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 此变量用于设置会话读取数据的时间点。例如，当您将变量设置为 "2017-11-11 20:20:20" 或像 "400036290571534337" 这样的 TSO 编号时，当前会话会读取该时刻的数据。

### tidb_source_id <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1`
- 范围：`[1, 15]`

<CustomContent platform="tidb">

- 此变量用于在[双向复制](/ticdc/ticdc-bidirectional-replication.md)集群中配置不同的集群 ID。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于在[双向复制](https://docs.pingcap.com/zh/tidb/stable/ticdc-bidirectional-replication)集群中配置不同的集群 ID。

</CustomContent>

### tidb_stats_cache_mem_quota <span class="version-mark">v6.1.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 单位：Byte
- 默认值：`0`，表示内存配额自动设置为 TiDB 实例总内存大小的一半。
- 范围：`[0, 1099511627776]`
- 此变量设置 TiDB 统计信息缓存的内存配额。

### tidb_stats_load_pseudo_timeout <span class="version-mark">v5.4.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制当 SQL 优化等待同步加载完整列统计信息的时间达到超时时，TiDB 的行为。默认值 `ON` 表示 SQL 优化在超时后恢复使用伪统计信息。如果此变量设置为 `OFF`，则 SQL 执行在超时后失败。

### tidb_stats_load_sync_wait <span class="version-mark">v5.4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/zh/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`100`
- 范围：`[0, 2147483647]`
- 单位：毫秒
- 此变量控制是否启用同步加载统计信息功能。值 `0` 表示该功能已禁用。要启用该功能，您可以将此变量设置为 SQL 优化最多可以等待同步加载完整列统计信息的超时时间（以毫秒为单位）。有关详细信息，请参阅[加载统计信息](/statistics.md#load-statistics)。

### tidb_stmt_summary_enable_persistent <span class="version-mark">v6.6.0 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

> **警告：**
>
> 语句摘要持久化是一项实验性功能。不建议在生产环境中使用它。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：GLOBAL
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量是只读的。它控制是否启用[语句摘要持久化](/statement-summary-tables.md#persist-statements-summary)。

<CustomContent platform="tidb">

- 此变量的值与配置项 [`tidb_stmt_summary_enable_persistent`](/tidb-configuration-file.md#tidb_stmt_summary_enable_persistent-new-in-v660) 的值相同。

</CustomContent>

### tidb_stmt_summary_filename <span class="version-mark">v6.6.0 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

> **警告：**
>
> 语句摘要持久化是一项实验性功能。不建议在生产环境中使用它。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：GLOBAL
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：String
- 默认值：`"tidb-statements.log"`
- 此变量是只读的。它指定在启用[语句摘要持久化](/statement-summary-tables.md#persist-statements-summary)时，持久数据写入的文件。

<CustomContent platform="tidb">

- 此变量的值与配置项 [`tidb_stmt_summary_filename`](/tidb-configuration-file.md#tidb_stmt_summary_filename-new-in-v660) 的值相同。

</CustomContent>

### tidb_stmt_summary_file_max_backups <span class="version-mark">v6.6.0 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

> **警告：**