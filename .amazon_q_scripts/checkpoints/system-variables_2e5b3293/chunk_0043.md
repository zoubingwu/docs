- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`16384`
- 范围：`[1, 1073741824]`
- 单位：字节

<CustomContent platform="tidb">

- 此变量用于控制 TiDB 发送到 TiKV 的事务提交请求的批量大小。如果应用程序工作负载中的大多数事务都有大量的写入操作，则将此变量调整为更大的值可以提高批量处理的性能。但是，如果此变量设置得太大并超过 TiKV 的 [`raft-entry-max-size`](/tikv-configuration-file.md#raft-entry-max-size) 限制，则提交可能会失败。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于控制 TiDB 发送到 TiKV 的事务提交请求的批量大小。如果应用程序工作负载中的大多数事务都有大量的写入操作，则将此变量调整为更大的值可以提高批量处理的性能。但是，如果此变量设置得太大并超过 TiKV 的单个日志的最大大小限制（默认为 8 MiB），则提交可能会失败。

</CustomContent>

### tidb_txn_entry_size_limit <span class="version-mark">v7.6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`0`
- 范围：`[0, 125829120]`
- 单位：字节

<CustomContent platform="tidb">

- 此变量用于动态修改 TiDB 配置项 [`performance.txn-entry-size-limit`](/tidb-configuration-file.md#txn-entry-size-limit-new-in-v4010-and-v500)。它限制 TiDB 中单行数据的大小，与配置项等效。此变量的默认值为 `0`，表示 TiDB 默认使用配置项 `txn-entry-size-limit` 的值。当此变量设置为非零值时，`txn-entry-size-limit` 也会设置为相同的值。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于动态修改 TiDB 配置项 [`performance.txn-entry-size-limit`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#txn-entry-size-limit-new-in-v4010-and-v500)。它限制 TiDB 中单行数据的大小，与配置项等效。此变量的默认值为 `0`，表示 TiDB 默认使用配置项 `txn-entry-size-limit` 的值。当此变量设置为非零值时，`txn-entry-size-limit` 也会设置为相同的值。

</CustomContent>

> **注意：**
>
> 使用 SESSION 作用域修改此变量只会影响当前用户会话，而不会影响 TiDB 内部会话。如果 TiDB 内部事务的条目大小超过配置项的限制，则可能会导致事务失败。因此，要动态增加限制，建议使用 GLOBAL 作用域修改变量。

### tidb_txn_mode

> **注意：**
>
> 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless)，此变量为只读。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`pessimistic`
- 可选值：`pessimistic`，`optimistic`
- 此变量用于设置事务模式。TiDB 3.0 支持悲观事务。自 TiDB 3.0.8 起，默认启用[悲观事务模式](/pessimistic-transaction.md)。
- 如果您将 TiDB 从 v3.0.7 或更早版本升级到 v3.0.8 或更高版本，则默认事务模式不会更改。**只有新创建的集群默认使用悲观事务模式**。
- 如果此变量设置为 "optimistic" 或 ""，则 TiDB 使用[乐观事务模式](/optimistic-transaction.md)。

### tidb_use_plan_baselines <span class="version-mark">v4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔
- 默认值：`ON`
- 此变量用于控制是否启用执行计划绑定功能。默认情况下启用，可以通过分配 `OFF` 值来禁用。有关执行计划绑定的使用，请参见[执行计划绑定](/sql-plan-management.md#create-a-binding)。

### tidb_wait_split_region_finish

> **注意：**
>
> 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless)，此变量为只读。

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔
- 默认值：`ON`
- 通常，分散 Region 需要很长时间，这取决于 PD 调度和 TiKV 负载。此变量用于设置在执行 `SPLIT REGION` 语句时，是否在所有 Region 完全分散后将结果返回给客户端：
    - `ON` 要求 `SPLIT REGIONS` 语句等待直到所有 Region 都被分散。
    - `OFF` 允许 `SPLIT REGIONS` 语句在完成分散所有 Region 之前返回。
- 请注意，在分散 Region 时，正在分散的 Region 的写入和读取性能可能会受到影响。在批量写入或数据导入场景中，建议在 Region 分散完成后导入数据。

### tidb_wait_split_region_timeout

> **注意：**
>
> 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless)，此变量为只读。

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`300`
- 范围：`[1, 2147483647]`
- 单位：秒
- 此变量用于设置执行 `SPLIT REGION` 语句的超时时间。如果语句在指定的时间值内未完全执行，则返回超时错误。

### tidb_window_concurrency <span class="version-mark">v4.0 新增</span>

> **警告：**
>
> 自 v5.0 起，此变量已弃用。请改用 [`tidb_executor_concurrency`](#tidb_executor_concurrency-new-in-v50) 进行设置。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`-1`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置窗口算子的并发度。
- 值为 `-1` 表示将使用 `tidb_executor_concurrency` 的值。

### tiflash_fastscan <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：`OFF`
- 类型：布尔
- 如果启用 [FastScan](/tiflash/use-fastscan.md)（设置为 `ON`），TiFlash 提供更高效的查询性能，但不保证查询结果的准确性或数据一致性。

### tiflash_fine_grained_shuffle_batch_size <span class="version-mark">v6.2.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：`8192`
- 范围：`[1, 18446744073709551615]`
- 启用 Fine Grained Shuffle 后，下推到 TiFlash 的窗口函数可以并行执行。此变量控制发送方发送的数据的批量大小。