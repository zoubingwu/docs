- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Duration
- 默认值: `168h`，表示 7 天
- 此变量控制历史统计信息在存储中保留的时长。

### tidb_idle_transaction_timeout <span class="version-mark">v7.6.0 新增</span>

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `0`
- 范围: `[0, 31536000]`
- 单位: 秒
- 此变量控制用户会话中事务的空闲超时时间。当用户会话处于事务状态并且空闲时间超过此变量的值时，TiDB 将终止该会话。空闲用户会话意味着没有活动的请求，并且会话正在等待新的请求。
- 默认值 `0` 表示无限制。

### tidb_ignore_prepared_cache_close_stmt <span class="version-mark">v6.0.0 新增</span>

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `OFF`
- 此变量用于设置是否忽略关闭预处理语句缓存的命令。
- 当此变量设置为 `ON` 时，将忽略 Binary 协议的 `COM_STMT_CLOSE` 命令和文本协议的 [`DEALLOCATE PREPARE`](/sql-statements/sql-statement-deallocate.md) 语句。有关详细信息，请参见 [忽略 `COM_STMT_CLOSE` 命令和 `DEALLOCATE PREPARE` 语句](/sql-prepared-plan-cache.md#ignore-the-com_stmt_close-command-and-the-deallocate-prepare-statement)。

### tidb_ignore_inlist_plan_digest <span class="version-mark">v7.6.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `OFF`
- 此变量控制 TiDB 在生成 Plan Digests 时是否忽略不同查询中 `IN` 列表中的元素差异。

    - 当为默认值 `OFF` 时，TiDB 在生成 Plan Digests 时不会忽略 `IN` 列表中的元素差异（包括元素数量的差异）。 `IN` 列表中的元素差异会导致不同的 Plan Digests。
    - 当设置为 `ON` 时，TiDB 会忽略 `IN` 列表中的元素差异（包括元素数量的差异），并使用 `...` 替换 Plan Digests 中 `IN` 列表中的元素。 在这种情况下，TiDB 会为相同类型的 `IN` 查询生成相同的 Plan Digests。

### tidb_index_join_batch_size

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Integer
- 默认值: `25000`
- 范围: `[1, 2147483647]`
- 单位: 行
- 此变量用于设置 `index lookup join` 操作的批处理大小。
- 在 OLAP 场景中使用较大的值，在 OLTP 场景中使用较小的值。

### tidb_index_join_double_read_penalty_cost_rate <span class="version-mark">v6.6.0 新增</span>

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Float
- 默认值: `0`
- 范围: `[0, 18446744073709551615]`
- 此变量确定是否对索引连接的选择应用惩罚成本，从而降低优化器选择索引连接的可能性，并增加选择替代连接方法（如哈希连接和 tiflash 连接）的可能性。
- 当选择索引连接时，会触发许多表查找请求，这会消耗过多的资源。 您可以使用此变量来降低优化器选择索引连接的可能性。
- 此变量仅在 [`tidb_cost_model_version`](/system-variables.md#tidb_cost_model_version-new-in-v620) 变量设置为 `2` 时生效。

### tidb_index_lookup_concurrency

> **警告：**
>
> 从 v5.0 开始，此变量已弃用。 请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `-1`
- 范围: `[1, 256]`
- 单位: 线程
- 此变量用于设置 `index lookup` 操作的并发性。
- 在 OLAP 场景中使用较大的值，在 OLTP 场景中使用较小的值。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tidb_index_lookup_join_concurrency

> **警告：**
>
> 从 v5.0 开始，此变量已弃用。 请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `-1`
- 范围: `[1, 256]`
- 单位: 线程
- 此变量用于设置 `index lookup join` 算法的并发性。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tidb_index_merge_intersection_concurrency <span class="version-mark">v6.5.0 新增</span>

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 默认值: `-1`
- 范围: `[1, 256]`
- 此变量设置索引合并执行的交集操作的最大并发数。 仅当 TiDB 在动态修剪模式下访问分区表时才有效。 实际并发数是 `tidb_index_merge_intersection_concurrency` 和分区表的分区数的较小值。
- 默认值 `-1` 表示使用 `tidb_executor_concurrency` 的值。

### tidb_index_lookup_size

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Integer
- 默认值: `20000`
- 范围: `[1, 2147483647]`
- 单位: 行
- 此变量用于设置 `index lookup` 操作的批处理大小。
- 在 OLAP 场景中使用较大的值，在 OLTP 场景中使用较小的值。

### tidb_index_serial_scan_concurrency

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: Integer
- 默认值: `1`
- 范围: `[1, 256]`
- 单位: 线程
- 此变量用于设置 `serial scan` 操作的并发性。
- 在 OLAP 场景中使用较大的值，在 OLTP 场景中使用较小的值。

### tidb_init_chunk_size

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `32`
- 范围: `[1, 32]`
- 单位: 行
- 此变量用于设置执行过程中初始 chunk 的行数。 一个 chunk 的行数直接影响单个查询所需的内存量。 您可以通过考虑查询中所有列的总宽度和 chunk 的行数来粗略估计单个 chunk 所需的内存。 将其与执行器的并发性结合起来，您可以粗略估计单个查询所需的总内存。 建议单个 chunk 的总内存不超过 16 MiB。

### tidb_isolation_read_engines <span class="version-mark">v4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域: SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 默认值: `tikv,tiflash,tidb`
- 此变量用于设置 TiDB 在读取数据时可以使用的存储引擎列表。

### tidb_last_ddl_info <span class="version-mark">v6.0.0 新增</span>