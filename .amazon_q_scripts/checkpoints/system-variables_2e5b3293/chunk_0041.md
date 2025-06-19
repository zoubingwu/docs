- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `OFF`
- `tidb_super_read_only` 旨在作为 MySQL 变量 `super_read_only` 的替代品来实现。但是，由于 TiDB 是一个分布式数据库，`tidb_super_read_only` 不会在执行后立即使数据库变为只读，而是最终变为只读。
- 具有 `SUPER` 或 `SYSTEM_VARIABLES_ADMIN` 权限的用户可以修改此变量。
- 此变量控制整个集群的只读状态。当变量为 `ON` 时，整个集群中的所有 TiDB 服务器都处于只读模式。在这种情况下，TiDB 仅执行不修改数据的语句，例如 `SELECT`、`USE` 和 `SHOW`。对于其他语句，例如 `INSERT` 和 `UPDATE`，TiDB 会拒绝在只读模式下执行这些语句。
- 使用此变量启用只读模式只能确保整个集群最终进入只读状态。如果您已在 TiDB 集群中更改了此变量的值，但该更改尚未传播到其他 TiDB 服务器，则未更新的 TiDB 服务器仍然**不是**处于只读模式。
- TiDB 在执行 SQL 语句之前检查只读标志。从 v6.2.0 开始，在提交 SQL 语句之前也会检查该标志。这有助于防止长时间运行的 [auto commit](/transaction-overview.md#autocommit) 语句在服务器进入只读模式后修改数据的情况。
- 启用此变量后，TiDB 通过以下方式处理未提交的事务：
    - 对于未提交的只读事务，您可以正常提交事务。
    - 对于未提交的非只读事务，将拒绝在这些事务中执行写操作的 SQL 语句。
    - 对于具有修改数据的未提交只读事务，将拒绝提交这些事务。
- 启用只读模式后，所有用户（包括具有 `SUPER` 权限的用户）都无法执行可能写入数据的 SQL 语句，除非该用户被明确授予 `RESTRICTED_REPLICA_WRITER_ADMIN` 权限。
- 当 [`tidb_restricted_read_only`](#tidb_restricted_read_only-new-in-v520) 系统变量设置为 `ON` 时，`tidb_super_read_only` 在某些情况下会受到 [`tidb_restricted_read_only`](#tidb_restricted_read_only-new-in-v520) 的影响。有关详细影响，请参阅 [`tidb_restricted_read_only`](#tidb_restricted_read_only-new-in-v520) 的描述。

### tidb_sysdate_is_now <span class="version-mark">v6.0.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `OFF`
- 此变量用于控制 `SYSDATE` 函数是否可以被 `NOW` 函数替换。此配置项与 MySQL 选项 [`sysdate-is-now`](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_sysdate-is-now) 具有相同的效果。

### tidb_sysproc_scan_concurrency <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `1`
- 范围: `[1, 4294967295]`。v7.5.0 及更早版本的最大值为 `256`。
- 此变量用于设置 TiDB 执行内部 SQL 语句（例如自动更新统计信息）时执行的扫描操作的并发性。

### tidb_table_cache_lease <span class="version-mark">v6.0.0 新增</span>

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `3`
- 范围: `[1, 10]`
- 单位: 秒
- 此变量用于控制 [缓存表](/cached-tables.md) 的租约时间，默认值为 `3`。此变量的值会影响对缓存表的修改。对缓存表进行修改后，最长的等待时间可能是 `tidb_table_cache_lease` 秒。如果表是只读的或可以接受较高的写入延迟，则可以增加此变量的值，以增加缓存表的有效时间并减少租约续订的频率。

### tidb_tmp_table_max_size <span class="version-mark">v5.3.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `67108864`
- 范围: `[1048576, 137438953472]`
- 单位: 字节
- 此变量用于设置单个[临时表](/temporary-tables.md)的最大大小。任何大小大于此变量值的临时表都会导致错误。

### tidb_top_sql_max_meta_count <span class="version-mark">v6.0.0 新增</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `5000`
- 范围: `[1, 10000]`

<CustomContent platform="tidb">

- 此变量用于控制 [Top SQL](/dashboard/top-sql.md) 每分钟收集的 SQL 语句类型的最大数量。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于控制 [Top SQL](https://docs.pingcap.com/tidb/stable/top-sql) 每分钟收集的 SQL 语句类型的最大数量。

</CustomContent>

### tidb_top_sql_max_time_series_count <span class="version-mark">v6.0.0 新增</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

> **注意：**
>
> 目前，TiDB Dashboard 中的 Top SQL 页面仅显示对负载贡献最大的前 5 种 SQL 查询类型，这与 `tidb_top_sql_max_time_series_count` 的配置无关。

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `100`
- 范围: `[1, 5000]`

<CustomContent platform="tidb">

- 此变量用于控制 [Top SQL](/dashboard/top-sql.md) 每分钟可以记录的对负载贡献最大的 SQL 语句的数量（即前 N 个）。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于控制 [Top SQL](https://docs.pingcap.com/tidb/stable/top-sql) 每分钟可以记录的对负载贡献最大的 SQL 语句的数量（即前 N 个）。

</CustomContent>

### tidb_track_aggregate_memory_usage

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `ON`
- 此变量控制 TiDB 是否跟踪聚合函数的内存使用情况。

> **警告：**
>
> 如果禁用此变量，TiDB 可能无法准确跟踪内存使用情况，并且无法控制相应 SQL 语句的内存使用情况。

### tidb_tso_client_batch_max_wait_time <span class="version-mark">v5.3.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Float
- 默认值: `0`
- 范围: `[0, 10]`
- 单位: 毫秒
- 此变量用于设置 TiDB 从 PD 请求 TSO 时，批量操作的最大等待时间。默认值为 `0`，表示没有额外的等待时间。