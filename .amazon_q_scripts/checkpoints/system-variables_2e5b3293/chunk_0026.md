- 对于 TiDB v6.5.0 及更高版本，此变量用于设置**会话**的内存配额阈值。如果会话在执行期间的内存配额超过阈值，TiDB 将执行由 [`tidb_mem_oom_action`](#tidb_mem_oom_action-new-in-v610) 定义的操作。请注意，从 TiDB v6.5.0 开始，会话的内存使用量包含会话中事务消耗的内存。
- 当您将变量值设置为 `0` 或 `-1` 时，内存阈值为正无穷大。当您设置的值小于 128 时，该值将默认为 `128`。

</CustomContent>

### tidb_memory_debug_mode_alarm_ratio

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Float
- 默认值：`0`
- 此变量表示 TiDB 内存调试模式下允许的内存统计误差值。
- 此变量用于 TiDB 的内部测试。**不建议**设置此变量。

### tidb_memory_debug_mode_min_heap_inuse

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 此变量用于 TiDB 的内部测试。**不建议**设置此变量。启用此变量会影响 TiDB 的性能。
- 配置此参数后，TiDB 将进入内存调试模式，以分析内存跟踪的准确性。TiDB 将在后续 SQL 语句的执行过程中频繁触发 GC，并比较实际内存使用量和内存统计信息。如果当前内存使用量大于 `tidb_memory_debug_mode_min_heap_inuse` 且内存统计误差超过 `tidb_memory_debug_mode_alarm_ratio`，TiDB 会将相关的内存信息输出到日志和文件。

### tidb_memory_usage_alarm_ratio

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Float
- 默认值：`0.7`
- 范围：`[0.0, 1.0]`

<CustomContent platform="tidb">

- 此变量设置触发 tidb-server 内存告警的内存使用率。默认情况下，当 TiDB 内存使用量超过其总内存的 70% 并且满足任何 [告警条件](/configure-memory-usage.md#trigger-the-alarm-of-excessive-memory-usage) 时，TiDB 会打印告警日志。
- 当此变量配置为 `0` 或 `1` 时，表示禁用内存阈值告警功能。
- 当此变量配置为大于 `0` 且小于 `1` 的值时，表示启用内存阈值告警功能。

    - 如果系统变量 [`tidb_server_memory_limit`](#tidb_server_memory_limit-new-in-v640) 的值为 `0`，则内存告警阈值为 `tidb_memory-usage-alarm-ratio * 系统内存大小`。
    - 如果系统变量 `tidb_server_memory_limit` 的值设置为大于 0，则内存告警阈值为 `tidb_memory-usage-alarm-ratio * tidb_server_memory_limit`。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量设置触发 [tidb-server 内存告警](https://docs.pingcap.com/zh/tidb/stable/configure-memory-usage#trigger-the-alarm-of-excessive-memory-usage) 的内存使用率。
- 当此变量配置为 `0` 或 `1` 时，表示禁用内存阈值告警功能。
- 当此变量配置为大于 `0` 且小于 `1` 的值时，表示启用内存阈值告警功能。

</CustomContent>

### tidb_memory_usage_alarm_keep_record_num <span class="version-mark">New in v6.4.0</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`5`
- 范围：`[1, 10000]`
- 当 tidb-server 内存使用量超过内存告警阈值并触发告警时，TiDB 默认仅保留最近 5 次告警期间生成的状态文件。您可以使用此变量调整此数量。

### tidb_merge_join_concurrency

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 范围：`[1, 256]`
- 默认值：`1`
- 此变量设置查询执行时 `MergeJoin` 算子的并发度。
- **不建议**设置此变量。修改此变量的值可能会导致数据正确性问题。

### tidb_merge_partition_stats_concurrency

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`1`
- 此变量指定 TiDB 分析分区表时，合并分区表统计信息的并发度。

### tidb_enable_async_merge_global_stats <span class="version-mark">New in v7.5.0</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`。当您将 TiDB 从低于 v7.5.0 的版本升级到 v7.5.0 或更高版本时，默认值为 `OFF`。
- 此变量用于 TiDB 异步合并全局统计信息，以避免 OOM 问题。

### tidb_metric_query_range_duration <span class="version-mark">New in v4.0</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`60`
- 范围：`[10, 216000]`
- 单位：秒
- 此变量用于设置查询 `METRICS_SCHEMA` 时生成的 Prometheus 语句的范围持续时间。

### tidb_metric_query_step <span class="version-mark">New in v4.0</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`60`
- 范围：`[10, 216000]`
- 单位：秒
- 此变量用于设置查询 `METRICS_SCHEMA` 时生成的 Prometheus 语句的步长。

### tidb_min_paging_size <span class="version-mark">New in v6.2.0</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`128`
- 范围：`[1, 9223372036854775807]`
- 单位：行
- 此变量用于设置 coprocessor 分页请求过程中的最小行数。将其设置为太小的值会增加 TiDB 和 TiKV 之间的 RPC 请求计数，而将其设置为太大的值可能会导致使用 IndexLookup with Limit 执行查询时性能下降。此变量的默认值在 OLTP 场景中比在 OLAP 场景中带来更好的性能。如果应用程序仅使用 TiKV 作为存储引擎，请考虑在执行 OLAP 工作负载查询时增加此变量的值，这可能会为您带来更好的性能。

![分页大小对 TPCH 的影响](/media/paging-size-impact-on-tpch.png)

如图所示，当启用 [`tidb_enable_paging`](#tidb_enable_paging-new-in-v540) 时，TPCH 的性能会受到 `tidb_min_paging_size` 和 [`tidb_max_paging_size`](#tidb_max_paging_size-new-in-v630) 设置的影响。纵轴是执行时间，越小越好。

### tidb_mpp_store_fail_ttl

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Duration
- 默认值：`60s`