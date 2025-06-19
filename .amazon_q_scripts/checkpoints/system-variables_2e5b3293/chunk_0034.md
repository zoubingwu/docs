- 类型: Float
- 范围: `[0, 2147483647]`
- 默认值: `24.0`
- 表示 TiFlash 计算的并发数。此变量在内部用于成本模型，不建议修改其值。

### tidb_opt_use_invisible_indexes <span class="version-mark">v8.0.0 新增</span>

- 作用域: SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Boolean
- 默认值: `OFF`
- 此变量控制优化器是否可以在当前会话中选择[不可见索引](/sql-statements/sql-statement-create-index.md#invisible-index)进行查询优化。不可见索引由 DML 语句维护，但不会被查询优化器使用。这在您希望在永久删除索引之前进行双重检查的情况下非常有用。当变量设置为 `ON` 时，优化器可以在会话中选择不可见索引进行查询优化。

### tidb_opt_write_row_id

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域: SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Boolean
- 默认值: `OFF`
- 此变量用于控制是否允许 `INSERT`、`REPLACE` 和 `UPDATE` 语句操作 `_tidb_rowid` 列。此变量只能在使用 TiDB 工具导入数据时使用。

### tidb_optimizer_selectivity_level

- 作用域: SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Integer
- 默认值: `0`
- 范围: `[0, 2147483647]`
- 此变量控制优化器估计逻辑的迭代。更改此变量的值后，优化器的估计逻辑将发生很大变化。目前，`0` 是唯一有效的值。不建议将其设置为其他值。

### tidb_partition_prune_mode <span class="version-mark">v5.1 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Enumeration
- 默认值: `dynamic`
- 可选值: `static`, `dynamic`, `static-only`, `dynamic-only`
- 指定分区表使用 `dynamic` 还是 `static` 模式。请注意，只有在收集了完整的表级统计信息或 GlobalStats 后，动态分区才有效。在收集 GlobalStats 之前，TiDB 将使用 `static` 模式。有关 GlobalStats 的详细信息，请参阅[在动态剪枝模式下收集分区表的统计信息](/statistics.md#collect-statistics-of-partitioned-tables-in-dynamic-pruning-mode)。有关动态剪枝模式的详细信息，请参阅[分区表的动态剪枝模式](/partitioned-table.md#dynamic-pruning-mode)。

### tidb_persist_analyze_options <span class="version-mark">v5.4.0 新增</span>

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `ON`
- 此变量控制是否启用 [ANALYZE 配置持久化](/statistics.md#persist-analyze-configurations)功能。

### tidb_pessimistic_txn_fair_locking <span class="version-mark">v7.0.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `ON`
- 确定是否对悲观事务使用增强的悲观锁唤醒模型。此模型严格控制悲观锁定单点冲突场景中悲观事务的唤醒顺序，以避免不必要的唤醒。它大大降低了现有唤醒机制的随机性带来的不确定性。如果在您的业务场景中遇到频繁的单点悲观锁定冲突（例如，频繁更新同一行数据），从而导致频繁的语句重试、高尾部延迟，甚至偶尔出现 `pessimistic lock retry limit reached` 错误，您可以尝试启用此变量来解决问题。
- 对于从低于 v7.0.0 的版本升级到 v7.0.0 或更高版本的 TiDB 集群，默认情况下禁用此变量。

> **注意：**
>
> - 根据具体的业务场景，启用此选项可能会导致频繁锁冲突的事务吞吐量降低（平均延迟增加）。
> - 此选项仅对需要锁定单个键的语句生效。如果一个语句需要同时锁定多行，则此选项对这些语句无效。
> - 此功能在 v6.6.0 中由 [`tidb_pessimistic_txn_aggressive_locking`](https://docs.pingcap.com/tidb/v6.6/system-variables#tidb_pessimistic_txn_aggressive_locking-new-in-v660) 变量引入，默认情况下禁用。

### tidb_placement_mode <span class="version-mark">v6.0.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Enumeration
- 默认值: `STRICT`
- 可选值: `STRICT`, `IGNORE`
- 此变量控制 DDL 语句是否忽略 [SQL 中指定的放置规则](/placement-rules-in-sql.md)。当变量值为 `IGNORE` 时，所有放置规则选项都将被忽略。
- 它旨在供逻辑转储/恢复工具使用，以确保即使分配了无效的放置规则，也可以始终创建表。这类似于 mysqldump 如何在每个转储文件的开头写入 `SET FOREIGN_KEY_CHECKS=0;`。

### `tidb_plan_cache_invalidation_on_fresh_stats` <span class="version-mark">v7.1.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `ON`
- 此变量控制是否在更新相关表的统计信息时自动使计划缓存失效。
- 启用此变量后，计划缓存可以更充分地利用统计信息来生成执行计划。例如：
    - 如果在统计信息可用之前生成执行计划，则计划缓存在统计信息可用后重新生成执行计划。
    - 如果表的数据分布发生变化，导致先前最佳的执行计划变为非最佳，则计划缓存在重新收集统计信息后重新生成执行计划。
- 对于从低于 v7.1.0 的版本升级到 v7.1.0 或更高版本的 TiDB 集群，默认情况下禁用此变量。

### `tidb_plan_cache_max_plan_size` <span class="version-mark">v7.1.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 默认值: `2097152` (即 2 MiB)
- 范围: `[0, 9223372036854775807]`，以字节为单位。也支持带有单位 "KiB|MiB|GiB|TiB" 的内存格式。`0` 表示没有限制。
- 此变量控制可以缓存在预处理或非预处理计划缓存中的计划的最大大小。如果计划的大小超过此值，则该计划将不会被缓存。有关更多详细信息，请参阅[预处理计划缓存的内存管理](/sql-prepared-plan-cache.md#memory-management-of-prepared-plan-cache)和[非预处理计划缓存](/sql-plan-management.md#usage)。

### tidb_pprof_sql_cpu <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域: GLOBAL
- 持久化到集群: 否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `0`
- 范围: `[0, 1]`