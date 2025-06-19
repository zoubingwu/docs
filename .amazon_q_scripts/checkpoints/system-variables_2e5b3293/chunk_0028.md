- 表示 TiDB 从临时磁盘读取或写入一个字节的数据的 I/O 成本。此变量在 [成本模型](/cost-model.md) 内部使用，**不**建议修改其值。

### tidb_opt_distinct_agg_push_down

- 作用域：SESSION
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于设置优化器是否执行将带有 `distinct` 的聚合函数（例如 `select count(distinct a) from t`）下推到 Coprocessor 的优化操作。
- 当带有 `distinct` 操作的聚合函数在查询中速度较慢时，您可以将变量值设置为 `1`。

在以下示例中，在启用 `tidb_opt_distinct_agg_push_down` 之前，TiDB 需要从 TiKV 读取所有数据并在 TiDB 端执行 `distinct`。 启用 `tidb_opt_distinct_agg_push_down` 后，`distinct a` 被下推到 Coprocessor，并且将 `group by` 列 `test.t.a` 添加到 `HashAgg_5`。

```sql
mysql> desc select count(distinct a) from test.t;
+-------------------------+----------+-----------+---------------+------------------------------------------+
| id                      | estRows  | task      | access object | operator info                            |
+-------------------------+----------+-----------+---------------+------------------------------------------+
| StreamAgg_6             | 1.00     | root      |               | funcs:count(distinct test.t.a)->Column#4 |
| └─TableReader_10        | 10000.00 | root      |               | data:TableFullScan_9                     |
|   └─TableFullScan_9     | 10000.00 | cop[tikv] | table:t       | keep order:false, stats:pseudo           |
+-------------------------+----------+-----------+---------------+------------------------------------------+
3 rows in set (0.01 sec)

mysql> set session tidb_opt_distinct_agg_push_down = 1;
Query OK, 0 rows affected (0.00 sec)

mysql> desc select count(distinct a) from test.t;
+---------------------------+----------+-----------+---------------+------------------------------------------+
| id                        | estRows  | task      | access object | operator info                            |
+---------------------------+----------+-----------+---------------+------------------------------------------+
| HashAgg_8                 | 1.00     | root      |               | funcs:count(distinct test.t.a)->Column#3 |
| └─TableReader_9           | 1.00     | root      |               | data:HashAgg_5                           |
|   └─HashAgg_5             | 1.00     | cop[tikv] |               | group by:test.t.a,                       |
|     └─TableFullScan_7     | 10000.00 | cop[tikv] | table:t       | keep order:false, stats:pseudo           |
+---------------------------+----------+-----------+---------------+------------------------------------------+
4 rows in set (0.00 sec)
```

### tidb_opt_enable_correlation_adjustment

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制优化器是否基于列顺序相关性来估计行数

### tidb_opt_enable_hash_join <span class="version-mark">v6.5.6、v7.1.2 和 v7.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制优化器是否为表选择哈希连接。 默认值为 `ON`。 如果设置为 `OFF`，则优化器在生成执行计划时会避免选择哈希连接，除非没有其他连接算法可用。
- 如果同时配置了系统变量 `tidb_opt_enable_hash_join` 和 `HASH_JOIN` hint，则 `HASH_JOIN` hint 优先。 即使 `tidb_opt_enable_hash_join` 设置为 `OFF`，当您在查询中指定 `HASH_JOIN` hint 时，TiDB 优化器仍然会强制执行哈希连接计划。

### tidb_opt_enable_non_eval_scalar_subquery <span class="version-mark">v7.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于控制 `EXPLAIN` 语句是否禁用在优化阶段可以展开的常量子查询的执行。 当此变量设置为 `OFF` 时，`EXPLAIN` 语句会在优化阶段提前展开子查询。 当此变量设置为 `ON` 时，`EXPLAIN` 语句不会在优化阶段展开子查询。 有关更多信息，请参见 [禁用子查询扩展](/explain-walkthrough.md#disable-the-early-execution-of-subqueries)。

### tidb_opt_enable_late_materialization <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制是否启用 [TiFlash 延迟物化](/tiflash/tiflash-late-materialization.md) 功能。 请注意，TiFlash 延迟物化在 [快速扫描模式](/tiflash/use-fastscan.md) 下不起作用。
- 当此变量设置为 `OFF` 以禁用 TiFlash 延迟物化功能时，为了处理带有过滤条件（`WHERE` 子句）的 `SELECT` 语句，TiFlash 会在过滤之前扫描所需列的所有数据。 当此变量设置为 `ON` 以启用 TiFlash 延迟物化功能时，TiFlash 可以首先扫描与下推到 TableScan 算子的过滤条件相关的列数据，过滤出满足条件的行，然后扫描这些行的其他列的数据以进行进一步计算，从而减少数据处理的 IO 扫描和计算。

### tidb_opt_enable_mpp_shared_cte_execution <span class="version-mark">v7.2.0 新增</span>

> **警告：**
>
> 此变量控制的功能是实验性的。 不建议在生产环境中使用它。 此功能可能会更改或删除，恕不另行通知。 如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制非递归 [公共表表达式 (CTE)](/sql-statements/sql-statement-with.md) 是否可以在 TiFlash MPP 上执行。 默认情况下，当禁用此变量时，CTE 在 TiDB 上执行，与启用此功能相比，性能差距很大。

### tidb_opt_enable_fuzzy_binding <span class="version-mark">v7.6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制是否启用 [跨数据库绑定](/sql-plan-management.md#cross-database-binding) 功能。

### tidb_opt_fix_control <span class="version-mark">v6.5.3 和 v7.1.0 新增</span>

<CustomContent platform="tidb">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：String
- 默认值：`""`
- 此变量用于控制优化器的一些内部行为。
- 优化器的行为可能因用户场景或 SQL 语句而异。 此变量提供了对优化器更细粒度的控制，并有助于防止升级后由于优化器中的行为更改而导致的性能下降。
- 有关更详细的介绍，请参见 [优化器修复控制](/optimizer-fix-controls.md)。