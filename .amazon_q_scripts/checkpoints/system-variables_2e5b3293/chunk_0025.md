- 该变量用于设置允许缓存的最大 schema 版本数（为相应版本修改的表 ID）。取值范围为 100 ~ 16384。

### tidb_max_paging_size <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`50000`
- 范围：`[1, 9223372036854775807]`
- 单位：行
- 该变量用于设置 Coprocessor 分页请求过程中的最大行数。将其设置为太小的值会增加 TiDB 和 TiKV 之间的 RPC 计数，而将其设置为太大的值在某些情况下会导致过多的内存使用，例如加载数据和全表扫描。此变量的默认值在 OLTP 场景中比在 OLAP 场景中带来更好的性能。如果应用程序仅使用 TiKV 作为存储引擎，请考虑在执行 OLAP 工作负载查询时增加此变量的值，这可能会带来更好的性能。

### tidb_max_tiflash_threads <span class="version-mark">v6.1.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[-1, 256]`
- 单位：线程
- 该变量用于设置 TiFlash 执行请求的最大并发数。默认值为 `-1`，表示此系统变量无效，最大并发数取决于 TiFlash 配置 `profiles.default.max_threads` 的设置。当值为 `0` 时，TiFlash 会自动配置最大线程数。

### tidb_mem_oom_action <span class="version-mark">v6.1.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`CANCEL`
- 可选值：`CANCEL`，`LOG`

<CustomContent platform="tidb">

- 指定当单个 SQL 语句超过 `tidb_mem_quota_query` 指定的内存配额且无法溢出到磁盘时，TiDB 执行的操作。有关详细信息，请参阅 [TiDB 内存控制](/configure-memory-usage.md)。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 指定当单个 SQL 语句超过 [`tidb_mem_quota_query`](#tidb_mem_quota_query) 指定的内存配额且无法溢出到磁盘时，TiDB 执行的操作。

</CustomContent>

- 默认值为 `CANCEL`，但在 TiDB v4.0.2 及更早版本中，默认值为 `LOG`。
- 此设置以前是一个 `tidb.toml` 选项 (`oom-action`)，但从 TiDB v6.1.0 开始更改为系统变量。

### tidb_mem_quota_analyze <span class="version-mark">v6.1.0 新增</span>

> **警告：**
>
> 目前，`ANALYZE` 内存配额是一项实验性功能，并且在生产环境中内存统计信息可能不准确。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[-1, 9223372036854775807]`
- 单位：字节
- 此变量控制 TiDB 更新统计信息的最大内存使用量。当您手动执行 [`ANALYZE TABLE`](/sql-statements/sql-statement-analyze-table.md) 以及 TiDB 在后台自动分析任务时，会发生这种内存使用。当总内存使用量超过此阈值时，用户执行的 `ANALYZE` 将退出，并报告一条错误消息，提醒您尝试降低采样率或稍后重试。如果 TiDB 后台的自动任务因超过内存阈值而退出，并且使用的采样率高于默认值，则 TiDB 将使用默认采样率重试更新。当此变量值为负数或零时，TiDB 不限制手动和自动更新任务的内存使用量。

> **注意：**
>
> 仅当在 TiDB 启动配置文件中启用了 `run-auto-analyze` 时，才会在 TiDB 集群中触发 `auto_analyze`。

### tidb_mem_quota_apply_cache <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`33554432` (32 MiB)
- 范围：`[0, 9223372036854775807]`
- 单位：字节
- 该变量用于设置 `Apply` 算子中本地缓存的内存使用阈值。
- `Apply` 算子中的本地缓存用于加速 `Apply` 算子的计算。您可以将变量设置为 `0` 以禁用 `Apply` 缓存功能。

### tidb_mem_quota_binding_cache <span class="version-mark">v6.0.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`67108864`
- 范围：`[0, 2147483647]`
- 单位：字节
- 该变量用于设置缓存 bindings 所用内存的阈值。
- 如果系统创建或捕获过多的 bindings，导致过度使用内存空间，TiDB 会在日志中返回警告。在这种情况下，缓存无法容纳所有可用的 bindings 或确定要存储哪些 bindings。因此，某些查询可能会错过它们的 bindings。要解决此问题，您可以增加此变量的值，这将增加用于缓存 bindings 的内存。修改此参数后，您需要运行 `admin reload bindings` 以重新加载 bindings 并验证修改。

### tidb_mem_quota_query

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1073741824` (1 GiB)
- 范围：`[-1, 9223372036854775807]`
- 单位：字节

<CustomContent platform="tidb">

- 对于低于 TiDB v6.1.0 的版本，这是一个会话范围变量，并使用 `tidb.toml` 中的 `mem-quota-query` 值作为初始值。从 v6.1.0 开始，`tidb_mem_quota_query` 是一个 `SESSION | GLOBAL` 范围变量。
- 对于低于 TiDB v6.5.0 的版本，此变量用于设置 **查询** 的内存配额阈值。如果查询在执行期间的内存配额超过阈值，TiDB 将执行由 [`tidb_mem_oom_action`](#tidb_mem_oom_action-new-in-v610) 定义的操作。
- 对于 TiDB v6.5.0 及更高版本，此变量用于设置 **会话** 的内存配额阈值。如果会话在执行期间的内存配额超过阈值，TiDB 将执行由 [`tidb_mem_oom_action`](#tidb_mem_oom_action-new-in-v610) 定义的操作。请注意，从 TiDB v6.5.0 开始，会话的内存使用量包含会话中事务消耗的内存。有关 TiDB v6.5.0 及更高版本中事务内存使用量的控制行为，请参阅 [`txn-total-size-limit`](/tidb-configuration-file.md#txn-total-size-limit)。
- 当您将变量值设置为 `0` 或 `-1` 时，内存阈值为正无穷大。当您设置的值小于 128 时，该值将默认为 `128`。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 对于低于 TiDB v6.1.0 的版本，这是一个会话范围变量。从 v6.1.0 开始，`tidb_mem_quota_query` 是一个 `SESSION | GLOBAL` 范围变量。
- 对于低于 TiDB v6.5.0 的版本，此变量用于设置 **查询** 的内存配额阈值。如果查询在执行期间的内存配额超过阈值，TiDB 将执行由 [`tidb_mem_oom_action`](#tidb_mem_oom_action-new-in-v610) 定义的操作。