- 从 v6.1.0 版本开始，TiDB 的 [Join Reorder](/join-reorder.md) 算法支持 Outer Join。此变量控制 TiDB 是否启用 Join Reorder 对 Outer Join 的支持。
- 如果您的集群是从早期版本的 TiDB 升级而来，请注意以下事项：

    - 如果升级前的 TiDB 版本早于 v6.1.0，则升级后此变量的默认值为 `ON`。
    - 如果升级前的 TiDB 版本为 v6.1.0 或更高版本，则升级后此变量的默认值与升级前的值保持一致。

### `tidb_enable_inl_join_inner_multi_pattern` <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制当内表上有 `Selection` 或 `Projection` 算子时，是否支持 Index Join。默认值 `OFF` 表示在这种情况下不支持 Index Join。

### tidb_enable_ordered_result_mode

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 指定是否自动对最终输出结果进行排序。
- 例如，启用此变量后，TiDB 将 `SELECT a, MAX(b) FROM t GROUP BY a` 处理为 `SELECT a, MAX(b) FROM t GROUP BY a ORDER BY a, MAX(b)`。

### tidb_enable_paging <span class="version-mark">v5.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否使用分页的方法发送 Coprocessor 请求。对于 [v5.4.0, v6.2.0) 中的 TiDB 版本，此变量仅对 `IndexLookup` 算子生效；对于 v6.2.0 及更高版本，此变量全局生效。从 v6.4.0 开始，此变量的默认值从 `OFF` 更改为 `ON`。
- 用户场景：

    - 在所有 OLTP 场景中，建议使用分页方法。
    - 对于使用 `IndexLookup` 和 `Limit` 的读取查询，并且 `Limit` 无法下推到 `IndexScan`，读取查询可能存在高延迟，并且 TiKV `Unified read pool CPU` 的使用率很高。在这种情况下，由于 `Limit` 算子只需要少量数据，如果将 [`tidb_enable_paging`](#tidb_enable_paging-new-in-v540) 设置为 `ON`，TiDB 处理的数据量会减少，从而降低查询延迟和资源消耗。
    - 在使用 [Dumpling](https://docs.pingcap.com/tidb/stable/dumpling-overview) 进行数据导出和全表扫描等场景中，启用分页可以有效降低 TiDB 进程的内存消耗。

> **注意：**
>
> 在使用 TiKV 作为存储引擎而不是 TiFlash 的 OLAP 场景中，启用分页在某些情况下可能会导致性能下降。如果发生性能下降，请考虑使用此变量禁用分页，或者使用 [`tidb_min_paging_size`](/system-variables.md#tidb_min_paging_size-new-in-v620) 和 [`tidb_max_paging_size`](/system-variables.md#tidb_max_paging_size-new-in-v630) 变量来调整分页大小的行数范围。

### tidb_enable_parallel_apply <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制是否为 `Apply` 算子启用并发。并发数由 `tidb_executor_concurrency` 变量控制。`Apply` 算子处理相关子查询，默认情况下没有并发，因此执行速度很慢。将此变量值设置为 `1` 可以增加并发并加快执行速度。目前，默认情况下禁用 `Apply` 的并发。

### tidb_enable_parallel_hashagg_spill <span class="version-mark">v8.0.0 新增</span>

> **警告：**
>
> 目前，此变量控制的功能是实验性的。不建议在生产环境中使用。如果您发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：v8.1.0 为 `ON`；v8.1.1 及之后的 8.1 patch 版本为 `OFF`
- 此变量控制 TiDB 是否支持并行 HashAgg 算法的磁盘溢出。当它为 `ON` 时，可以为并行 HashAgg 算法触发磁盘溢出。此变量将在未来版本中此功能普遍可用后被弃用。

### tidb_enable_pipelined_window_function

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量指定是否对 [窗口函数](/functions-and-operators/window-functions.md) 使用流水线执行算法。

### tidb_enable_plan_cache_for_param_limit <span class="version-mark">v6.6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制 Prepared Plan Cache 是否缓存以变量作为 `LIMIT` 参数 (`LIMIT ?`) 的执行计划。默认值为 `ON`，表示 Prepared Plan Cache 支持缓存此类执行计划。请注意，Prepared Plan Cache 不支持缓存变量大于 10000 的执行计划。

### tidb_enable_plan_cache_for_subquery <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制 Prepared Plan Cache 是否缓存包含子查询的查询。

### tidb_enable_plan_replayer_capture

<CustomContent platform="tidb-cloud">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否启用 `PLAN REPLAYER CAPTURE` 功能。默认值 `ON` 表示启用 `PLAN REPLAYER CAPTURE` 功能。

</CustomContent>

<CustomContent platform="tidb">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否启用 [`PLAN REPLAYER CAPTURE` 功能](/sql-plan-replayer.md#use-plan-replayer-capture-to-capture-target-plans)。默认值 `ON` 表示启用 `PLAN REPLAYER CAPTURE` 功能。

</CustomContent>

### tidb_enable_plan_replayer_continuous_capture <span class="version-mark">v7.0.0 新增</span>

<CustomContent platform="tidb-cloud">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制是否启用 `PLAN REPLAYER CONTINUOUS CAPTURE` 功能。默认值 `OFF` 表示禁用该功能。

</CustomContent>

<CustomContent platform="tidb">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制是否启用 [`PLAN REPLAYER CONTINUOUS CAPTURE` 功能](/sql-plan-replayer.md#use-plan-replayer-continuous-capture)。默认值 `OFF` 表示禁用该功能。

</CustomContent>

### tidb_enable_prepared_plan_cache <span class="version-mark">v6.1.0 新增</span>

- 作用域：SESSION | GLOBAL