- `RESTRICTED_USER_ADMIN`: 阻止其他用户更改或删除用户帐户的能力。

### tidb_enable_exchange_partition

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否启用 [`exchange partitions with tables`](/partitioned-table.md#partition-management) 功能。默认值为 `ON`，即默认启用 `exchange partitions with tables`。
- 此变量自 v6.3.0 起已弃用。它的值将固定为默认值 `ON`，即默认启用 `exchange partitions with tables`。

### tidb_enable_extended_stats

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量指示 TiDB 是否可以收集扩展统计信息来指导优化器。有关更多信息，请参见[扩展统计信息简介](/extended-statistics.md)。

### tidb_enable_external_ts_read <span class="version-mark">v6.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 如果此变量设置为 `ON`，TiDB 会使用 [`tidb_external_ts`](#tidb_external_ts-new-in-v640) 指定的时间戳读取数据。

### tidb_external_ts <span class="version-mark">v6.4.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 如果 [`tidb_enable_external_ts_read`](#tidb_enable_external_ts_read-new-in-v640) 设置为 `ON`，TiDB 会使用此变量指定的时间戳读取数据。

### tidb_enable_fast_analyze

> **警告：**
>
> 从 v7.5.0 开始，此变量已弃用。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于设置是否启用统计信息 `Fast Analyze` 功能。
- 如果启用了统计信息 `Fast Analyze` 功能，TiDB 会随机抽样大约 10,000 行数据作为统计信息。当数据分布不均匀或数据量较小时，统计信息的准确性较低。这可能会导致非最佳执行计划，例如，选择错误的索引。如果常规 `Analyze` 语句的执行时间可以接受，建议禁用 `Fast Analyze` 功能。

### tidb_enable_fast_table_check <span class="version-mark">v7.2.0 新增</span>

> **注意：**
>
> 此变量不适用于[多值索引](/sql-statements/sql-statement-create-index.md#multi-valued-indexes)和前缀索引。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制是否使用基于校验和的方法来快速检查表中数据和索引的完整性。默认值 `ON` 表示默认启用此功能。
- 启用此变量后，TiDB 可以更快地执行 [`ADMIN CHECK [TABLE|INDEX]`](/sql-statements/sql-statement-admin-check-table-index.md) 语句。

### tidb_enable_foreign_key <span class="version-mark">v6.3.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：v6.6.0 之前，默认值为 `OFF`。从 v6.6.0 开始，默认值为 `ON`。
- 此变量控制是否启用 `FOREIGN KEY` 功能。

### tidb_enable_gc_aware_memory_track

> **警告：**
>
> 此变量是 TiDB 中用于调试的内部变量。它可能会在未来的版本中被删除。**请勿**设置此变量。

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制是否启用 GC-Aware 内存跟踪。

### tidb_enable_global_index <span class="version-mark">v7.6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 可选值：`OFF`，`ON`
- 此变量控制是否支持为分区表创建 `Global indexes`。`Global index` 目前处于开发阶段。**不建议修改此系统变量的值**。

### tidb_enable_non_prepared_plan_cache

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制是否启用 [Non-prepared plan cache](/sql-non-prepared-plan-cache.md) 功能。
- 启用此功能可能会产生额外的内存和 CPU 开销，并且可能不适用于所有情况。请根据您的实际情况确定是否启用此功能。

### tidb_enable_non_prepared_plan_cache_for_dml <span class="version-mark">v7.1.0 新增</span>

> **警告：**
>
> 用于 DML 语句的非预备执行计划缓存是一项实验性功能。不建议在生产环境中使用它。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`。
- 此变量控制是否为 DML 语句启用 [Non-prepared plan cache](/sql-non-prepared-plan-cache.md) 功能。

### tidb_enable_gogc_tuner <span class="version-mark">v6.4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否启用 GOGC Tuner。

### tidb_enable_historical_stats

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否启用历史统计信息。默认值从 `OFF` 更改为 `ON`，这意味着默认启用历史统计信息。

### tidb_enable_historical_stats_for_capture

> **警告：**
>
> 此变量控制的功能在当前 TiDB 版本中尚未完全实现。请勿更改默认值。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制 `PLAN REPLAYER CAPTURE` 捕获的信息是否默认包含历史统计信息。默认值 `OFF` 表示默认不包含历史统计信息。

### tidb_enable_index_merge <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> - 将 TiDB 集群从低于 v4.0.0 的版本升级到 v5.4.0 或更高版本后，默认情况下禁用此变量，以防止由于执行计划的更改而导致性能下降。
>
> - 将 TiDB 集群从 v4.0.0 或更高版本升级到 v5.4.0 或更高版本后，此变量保持升级前的设置。