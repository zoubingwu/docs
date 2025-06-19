- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 类型：String
- 这是一个只读变量。它在 TiDB 内部用于获取当前会话中最后一次 DDL 操作的信息。
    - "query": 最后一次 DDL 查询字符串。
    - "seq_num": 每个 DDL 操作的序列号。它用于标识 DDL 操作的顺序。

### tidb_last_query_info <span class="version-mark">v4.0.14 新增</span>

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 这是一个只读变量。它在 TiDB 内部用于查询最后一条 DML 语句的事务信息。该信息包括：
    - `txn_scope`: 事务的作用域，可以是 `global` 或 `local`。
    - `start_ts`: 事务的开始时间戳。
    - `for_update_ts`: 先前执行的 DML 语句的 `for_update_ts`。这是一个 TiDB 内部术语，用于测试。通常，您可以忽略此信息。
    - `error`: 错误信息（如果有）。
    - `ru_consumption`: 执行语句消耗的 [RU](/tidb-resource-control.md#what-is-request-unit-ru)。

### tidb_last_txn_info <span class="version-mark">v4.0.9 新增</span>

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：String
- 此变量用于获取当前会话中最后一次事务的信息。这是一个只读变量。事务信息包括：
    - 事务作用域。
    - 开始和提交 TS。
    - 事务提交模式，可能是两阶段提交、一阶段提交或异步提交。
    - 从异步提交或一阶段提交回退到两阶段提交的事务信息。
    - 遇到的错误。

### tidb_last_plan_replayer_token <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：String
- 此变量是只读的，用于获取当前会话中最后一次 `PLAN REPLAYER DUMP` 执行的结果。

### tidb_load_based_replica_read_threshold <span class="version-mark">v7.0.0 新增</span>

<CustomContent platform="tidb">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`"1s"`
- 范围：`[0s, 1h]`
- 类型：String
- 此变量用于设置触发基于负载的副本读取的阈值。当 leader 节点的估计队列时间超过阈值时，TiDB 优先从 follower 节点读取数据。格式为时间长度，例如 `"100ms"` 或 `"1s"`。有关更多详细信息，请参阅[解决热点问题](/troubleshoot-hot-spot-issues.md#scatter-read-hotspots)。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`"1s"`
- 范围：`[0s, 1h]`
- 类型：String
- 此变量用于设置触发基于负载的副本读取的阈值。当 leader 节点的估计队列时间超过阈值时，TiDB 优先从 follower 节点读取数据。格式为时间长度，例如 `"100ms"` 或 `"1s"`。有关更多详细信息，请参阅[解决热点问题](https://docs.pingcap.com/tidb/stable/troubleshoot-hot-spot-issues#scatter-read-hotspots)。

</CustomContent>

### `tidb_load_binding_timeout` <span class="version-mark">v8.0.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`200`
- 范围：`(0, 2147483647]`
- 单位：毫秒
- 此变量用于控制加载绑定的超时时间。如果加载绑定的执行时间超过此值，则加载将停止。

### `tidb_lock_unchanged_keys` <span class="version-mark">v7.1.1 和 v7.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制是否锁定以下场景中的特定键。当值设置为 `ON` 时，这些键将被锁定。当值设置为 `OFF` 时，这些键将不会被锁定。
    - `INSERT IGNORE` 和 `REPLACE` 语句中的重复键。在 v6.1.6 之前，这些键未被锁定。此问题已在 [#42121](https://github.com/pingcap/tidb/issues/42121) 中修复。
    - `UPDATE` 语句中键的值未更改时的唯一键。在 v6.5.2 之前，这些键未被锁定。此问题已在 [#36438](https://github.com/pingcap/tidb/issues/36438) 中修复。
- 为了保持事务的一致性和合理性，不建议更改此值。如果升级 TiDB 由于这两个修复导致严重的性能问题，并且可以接受没有锁定的行为（请参阅上述问题），则可以将此变量设置为 `OFF`。

### tidb_log_file_max_days <span class="version-mark">v5.3.0 新增</span>

> **注意：**
>
> 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless)，此变量是只读的。

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 2147483647]`

<CustomContent platform="tidb">

- 此变量用于设置当前 TiDB 实例上日志保留的最大天数。其值默认为配置文件中 [`max-days`](/tidb-configuration-file.md#max-days) 配置的值。更改变量值仅影响当前 TiDB 实例。TiDB 重启后，变量值将被重置，配置值不受影响。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于设置当前 TiDB 实例上日志保留的最大天数。

</CustomContent>

### tidb_low_resolution_tso

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于设置是否启用低精度 TSO 功能。启用此功能后，TiDB 使用缓存的时间戳读取数据。默认情况下，缓存的时间戳每 2 秒更新一次。从 v8.0.0 开始，您可以通过 [`tidb_low_resolution_tso_update_interval`](#tidb_low_resolution_tso_update_interval-new-in-v800) 配置更新间隔。
- 主要适用场景是在读取旧数据可以接受的情况下，减少小型只读事务获取 TSO 的开销。

### `tidb_low_resolution_tso_update_interval` <span class="version-mark">v8.0.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`2000`
- 范围：`[10, 60000]`
- 单位：毫秒
- 此变量用于设置低精度 TSO 功能中使用的缓存时间戳的更新间隔，以毫秒为单位。
- 仅当启用 [`tidb_low_resolution_tso`](#tidb_low_resolution_tso) 时，此变量才可用。

### tidb_max_auto_analyze_time <span class="version-mark">v6.1.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`43200`
- 范围：`[0, 2147483647]`
- 单位：秒