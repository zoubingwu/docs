- 此变量用于控制是否在 profile 输出中标记相应的 SQL 语句，以识别和排除性能问题。

### tidb_prefer_broadcast_join_by_exchange_data_size <span class="version-mark">v7.1.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：`OFF`
- 此变量控制 TiDB 在选择 [MPP Hash Join 算法](/tiflash/use-tiflash-mpp-mode.md#algorithm-support-for-the-mpp-mode) 时，是否使用网络传输开销最小的算法。如果启用此变量，TiDB 将分别使用 `Broadcast Hash Join` 和 `Shuffled Hash Join` 估算网络中要交换的数据大小，然后选择较小的一个。
- 启用此变量后，[`tidb_broadcast_join_threshold_count`](/system-variables.md#tidb_broadcast_join_threshold_count-new-in-v50) 和 [`tidb_broadcast_join_threshold_size`](/system-variables.md#tidb_broadcast_join_threshold_size-new-in-v50) 将不会生效。

### tidb_prepared_plan_cache_memory_guard_ratio <span class="version-mark">v6.1.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Float
- 默认值：`0.1`
- 范围：`[0, 1]`
- 预处理计划缓存触发内存保护机制的阈值。有关详细信息，请参阅 [预处理计划缓存的内存管理](/sql-prepared-plan-cache.md)。
- 此设置以前是一个 `tidb.toml` 选项 (`prepared-plan-cache.memory-guard-ratio`)，但从 TiDB v6.1.0 开始更改为系统变量。

### tidb_prepared_plan_cache_size <span class="version-mark">v6.1.0 新增</span>

> **警告：**
>
> 从 v7.1.0 开始，此变量已弃用。请改用 [`tidb_session_plan_cache_size`](#tidb_session_plan_cache_size-new-in-v710) 进行设置。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`100`
- 范围：`[1, 100000]`
- 会话中可以缓存的最大计划数。有关详细信息，请参阅 [预处理计划缓存的内存管理](/sql-prepared-plan-cache.md)。
- 此设置以前是一个 `tidb.toml` 选项 (`prepared-plan-cache.capacity`)，但从 TiDB v6.1.0 开始更改为系统变量。

### tidb_projection_concurrency

> **警告：**
>
> 从 v5.0 开始，此变量已弃用。请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[-1, 256]`
- 单位：线程
- 此变量用于设置 `Projection` 算子的并发度。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tidb_query_log_max_len

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`4096` (4 KiB)
- 范围：`[0, 1073741824]`
- 单位：字节
- SQL 语句输出的最大长度。当语句的输出长度大于 `tidb_query_log_max_len` 值时，该语句将被截断输出。
- 此设置以前也可用作 `tidb.toml` 选项 (`log.query-log-max-len`)，但从 TiDB v6.1.0 开始仅作为系统变量。

### tidb_rc_read_check_ts <span class="version-mark">v6.0.0 新增</span>

> **警告：**
>
> - 此功能与 [`replica-read`](#tidb_replica_read-new-in-v40) 不兼容。请勿同时启用 `tidb_rc_read_check_ts` 和 `replica-read`。
> - 如果您的客户端使用游标，则不建议启用 `tidb_rc_read_check_ts`，以防客户端已使用前一批返回的数据，并且该语句最终失败。
> - 从 v7.0.0 开始，此变量对于使用预处理语句协议的游标提取读取模式不再有效。

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于优化时间戳获取，适用于读已提交隔离级别且读写冲突很少的场景。启用此变量可以避免获取全局时间戳的延迟和成本，并可以优化事务级别的读取延迟。
- 如果读写冲突严重，启用此功能将增加获取全局时间戳的成本和延迟，并可能导致性能下降。有关详细信息，请参阅 [读已提交隔离级别](/transaction-isolation-levels.md#read-committed-isolation-level)。

### tidb_rc_write_check_ts <span class="version-mark">v6.3.0 新增</span>

> **警告：**
>
> 此功能目前与 [`replica-read`](#tidb_replica_read-new-in-v40) 不兼容。启用此变量后，客户端发送的所有请求都不能使用 `replica-read`。因此，请勿同时启用 `tidb_rc_write_check_ts` 和 `replica-read`。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于优化时间戳的获取，适用于悲观事务的 `READ-COMMITTED` 隔离级别中点写冲突较少的场景。启用此变量可以避免在执行点写语句期间获取全局时间戳所带来的延迟和开销。目前，此变量适用于三种类型的点写语句：`UPDATE`、`DELETE` 和 `SELECT ...... FOR UPDATE`。点写语句是指使用主键或唯一键作为过滤条件，并且最终执行算子包含 `POINT-GET` 的写语句。
- 如果点写冲突严重，启用此变量将增加额外的开销和延迟，从而导致性能下降。有关详细信息，请参阅 [读已提交隔离级别](/transaction-isolation-levels.md#read-committed-isolation-level)。

### tidb_read_consistency <span class="version-mark">v5.4.0 新增</span>

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是（请注意，如果存在[非事务性 DML 语句](/non-transactional-dml.md)，则使用 hint 修改此变量的值可能不会生效。）
- 类型：String
- 默认值：`strict`
- 此变量用于控制自动提交读取语句的读取一致性。
- 如果变量值设置为 `weak`，则读取语句遇到的锁将被直接跳过，并且读取执行可能会更快，这是弱一致性读取模式。但是，事务语义（例如原子性）和分布式一致性（例如线性一致性）无法得到保证。
- 对于自动提交读取需要快速返回且可以接受弱一致性读取结果的用户场景，可以使用弱一致性读取模式。

### tidb_read_staleness <span class="version-mark">v5.4.0 新增</span>

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[-2147483648, 0]`