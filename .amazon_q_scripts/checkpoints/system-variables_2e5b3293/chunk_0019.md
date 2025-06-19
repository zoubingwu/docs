- 您可以使用 [`TIDB_ROW_CHECKSUM()`](/functions-and-operators/tidb-functions.md#tidb_row_checksum) 函数来获取行的校验和值。

### tidb_enforce_mpp <span class="version-mark">v5.1 新增</span>

- 作用域：SESSION
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`

<CustomContent platform="tidb">

- 要更改此默认值，请修改 [`performance.enforce-mpp`](/tidb-configuration-file.md#enforce-mpp) 配置值。

</CustomContent>

- 控制是否忽略优化器的成本估算，并强制使用 TiFlash 的 MPP 模式执行查询。取值选项如下：
    - `0` 或 `OFF`，表示不强制使用 MPP 模式（默认）。
    - `1` 或 `ON`，表示忽略成本估算，强制使用 MPP 模式。请注意，此设置仅在 `tidb_allow_mpp=true` 时生效。

MPP 是 TiFlash 引擎提供的分布式计算框架，支持节点间的数据交换，并提供高性能、高吞吐量的 SQL 算法。有关 MPP 模式选择的详细信息，请参考 [控制是否选择 MPP 模式](/tiflash/use-tiflash-mpp-mode.md#control-whether-to-select-the-mpp-mode)。

### tidb_evolve_plan_baselines <span class="version-mark">v4.0 新增</span>

> **警告：**
>
> 此变量控制的功能为实验性功能。不建议在生产环境中使用。如果发现 Bug，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于控制是否启用基线演进功能。有关详细介绍或用法，请参见 [基线演进](/sql-plan-management.md#baseline-evolution)。
- 为了减少基线演进对集群的影响，请使用以下配置：
    - 设置 `tidb_evolve_plan_task_max_time` 以限制每个执行计划的最大执行时间。默认值为 600 秒。
    - 设置 `tidb_evolve_plan_task_start_time` 和 `tidb_evolve_plan_task_end_time` 以限制时间窗口。默认值分别为 `00:00 +0000` 和 `23:59 +0000`。

### tidb_evolve_plan_task_end_time <span class="version-mark">v4.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Time
- 默认值：`23:59 +0000`
- 此变量用于设置一天中基线演进的结束时间。

### tidb_evolve_plan_task_max_time <span class="version-mark">v4.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`600`
- 范围：`[-1, 9223372036854775807]`
- 单位：秒
- 此变量用于限制基线演进功能中每个执行计划的最大执行时间。

### tidb_evolve_plan_task_start_time <span class="version-mark">v4.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Time
- 默认值：`00:00 +0000`
- 此变量用于设置一天中基线演进的开始时间。

### tidb_executor_concurrency <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`5`
- 范围：`[1, 256]`
- 单位：线程

此变量用于设置以下 SQL 算子的并发度（设置为一个值）：

- `index lookup`
- `index lookup join`
- `hash join`
- `hash aggregation`（`partial` 和 `final` 阶段）
- `window`
- `projection`

`tidb_executor_concurrency` 将以下现有系统变量作为一个整体进行合并，以便于管理：

+ `tidb_index_lookup_concurrency`
+ `tidb_index_lookup_join_concurrency`
+ `tidb_hash_join_concurrency`
+ `tidb_hashagg_partial_concurrency`
+ `tidb_hashagg_final_concurrency`
+ `tidb_projection_concurrency`
+ `tidb_window_concurrency`

自 v5.0 起，您仍然可以单独修改上面列出的系统变量（会返回弃用警告），并且您的修改只会影响相应的单个算子。之后，如果您使用 `tidb_executor_concurrency` 修改算子并发度，则单独修改的算子将不受影响。如果您想使用 `tidb_executor_concurrency` 修改所有算子的并发度，可以将上面列出的所有变量的值设置为 `-1`。

对于从早期版本升级到 v5.0 的系统，如果您没有修改上面列出的任何变量的值（这意味着 `tidb_hash_join_concurrency` 的值为 `5`，其余变量的值为 `4`），则先前由这些变量管理的算子并发度将自动由 `tidb_executor_concurrency` 管理。如果您修改了这些变量中的任何一个，则相应算子的并发度仍将由修改后的变量控制。

### tidb_expensive_query_time_threshold

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`60`
- 范围：`[10, 2147483647]`
- 单位：秒
- 此变量用于设置确定是否打印昂贵查询日志的阈值。昂贵查询日志和慢查询日志的区别在于：
    - 慢查询日志在语句执行后打印。
    - 昂贵查询日志打印正在执行的语句，其执行时间超过阈值，以及它们的相关信息。

### tidb_expensive_txn_time_threshold <span class="version-mark">v7.2.0 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`600`
- 范围：`[60, 2147483647]`
- 单位：秒
- 此变量控制记录昂贵事务的阈值，默认为 600 秒。当事务的持续时间超过阈值，且事务既未提交也未回滚时，该事务被认为是昂贵事务，并将被记录。

### tidb_force_priority

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`NO_PRIORITY`
- 可选值：`NO_PRIORITY`、`LOW_PRIORITY`、`HIGH_PRIORITY`、`DELAYED`
- 此变量用于更改在 TiDB 服务器上执行的语句的默认优先级。一个用例是确保执行 OLAP 查询的特定用户获得的优先级低于执行 OLTP 查询的用户。
- 默认值 `NO_PRIORITY` 表示不强制更改语句的优先级。

> **注意：**
>