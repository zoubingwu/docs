- 要查看此功能在日志中的所有记录，您需要将 TiDB 配置项 [`log.level`](/tidb-configuration-file.md#level) 设置为 `"info"` 或 `"debug"`，然后查询 `"GENERAL_LOG"` 字符串。记录以下信息：
    - `time`: 事件发生的时间。
    - `conn`: 当前会话的 ID。
    - `user`: 当前会话用户。
    - `schemaVersion`: 当前 schema 版本。
    - `txnStartTS`: 当前事务开始的时间戳。
    - `forUpdateTS`: 在悲观事务模式下，`forUpdateTS` 是当前 SQL 语句的时间戳。当悲观事务中发生写冲突时，TiDB 会重试当前正在执行的 SQL 语句并更新此时间戳。您可以通过 [`max-retry-count`](/tidb-configuration-file.md#max-retry-count) 配置重试次数。在乐观事务模型中，`forUpdateTS` 等同于 `txnStartTS`。
    - `isReadConsistency`: 指示当前事务隔离级别是否为读已提交 (RC)。
    - `current_db`: 当前数据库的名称。
    - `txn_mode`: 事务模式。可选值为 `OPTIMISTIC` 和 `PESSIMISTIC`。
    - `sql`: 与当前查询对应的 SQL 语句。

</CustomContent>

### tidb_non_prepared_plan_cache_size

> **警告：**
>
> 从 v7.1.0 开始，此变量已被弃用。请改用 [`tidb_session_plan_cache_size`](#tidb_session_plan_cache_size-new-in-v710) 进行设置。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`100`
- 范围：`[1, 100000]`
- 此变量控制 [Non-prepared plan cache](/sql-non-prepared-plan-cache.md) 可以缓存的最大执行计划数量。

### tidb_generate_binary_plan <span class="version-mark">New in v6.2.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否在慢日志和语句摘要中生成二进制编码的执行计划。
- 当此变量设置为 `ON` 时，您可以在 TiDB Dashboard 中查看可视化执行计划。请注意，TiDB Dashboard 仅提供在此变量启用后生成的执行计划的可视化显示。
- 您可以执行 [`SELECT tidb_decode_binary_plan('xxx...')`](/functions-and-operators/tidb-functions.md#tidb_decode_binary_plan) 语句来从二进制计划中解析特定计划。

### tidb_gogc_tuner_max_value <span class="version-mark">New in v7.5.0</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`500`
- 范围：`[10, 2147483647]`
- 该变量用于控制 GOGC Tuner 可以调整的 GOGC 最大值。

### tidb_gogc_tuner_min_value <span class="version-mark">New in v7.5.0</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`100`
- 范围：`[10, 2147483647]`
- 该变量用于控制 GOGC Tuner 可以调整的 GOGC 最小值。

### tidb_gogc_tuner_threshold <span class="version-mark">New in v6.4.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`0.6`
- 范围：`[0, 0.9)`
- 此变量指定调整 GOGC 的最大内存阈值。当内存超过此阈值时，GOGC Tuner 停止工作。

### tidb_guarantee_linearizability <span class="version-mark">New in v5.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制异步提交的 commit TS 的计算方式。默认情况下（值为 `ON`），两阶段提交从 PD 服务器请求一个新的 TS，并使用该 TS 来计算最终的 commit TS。在这种情况下，保证所有并发事务的线性一致性。
- 如果将此变量设置为 `OFF`，则会跳过从 PD 服务器获取 TS 的过程，但代价是仅保证因果一致性，而不保证线性一致性。有关更多详细信息，请参见博客文章 [Async Commit, the Accelerator for Transaction Commit in TiDB 5.0](https://www.pingcap.com/blog/async-commit-the-accelerator-for-transaction-commit-in-tidb-5-0/)。
- 对于仅需要因果一致性的场景，您可以将此变量设置为 `OFF` 以提高性能。

### tidb_hash_exchange_with_new_collation

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否在启用新排序规则的集群中生成 MPP 哈希分区交换算子。`true` 表示生成该算子，`false` 表示不生成。
- 此变量用于 TiDB 的内部操作。**不建议**设置此变量。

### tidb_hash_join_concurrency

> **警告：**
>
> 自 v5.0 起，此变量已被弃用。请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置 `hash join` 算法的并发度。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tidb_hashagg_final_concurrency

> **警告：**
>
> 自 v5.0 起，此变量已被弃用。请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置在 `final` 阶段执行并发 `hash aggregation` 算法的并发度。
- 当聚合函数的参数不是 distinct 时，`HashAgg` 会在两个阶段并发运行，分别是 `partial` 阶段和 `final` 阶段。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tidb_hashagg_partial_concurrency

> **警告：**
>
> 自 v5.0 起，此变量已被弃用。请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置在 `partial` 阶段执行并发 `hash aggregation` 算法的并发度。
- 当聚合函数的参数不是 distinct 时，`HashAgg` 会在两个阶段并发运行，分别是 `partial` 阶段和 `final` 阶段。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tidb_historical_stats_duration <span class="version-mark">New in v6.6.0</span>

- 作用域：GLOBAL
- 持久化到集群：是