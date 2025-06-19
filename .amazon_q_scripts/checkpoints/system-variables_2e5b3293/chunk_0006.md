- 用于 SSL/TLS 连接的私钥文件（如果存在）的位置。此变量的值由 TiDB 配置文件项 [`ssl-key`](/tidb-configuration-file.md#ssl-cert) 定义。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 范围：无
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 用于 SSL/TLS 连接的私钥文件（如果存在）的位置。此变量的值由 TiDB 配置文件项 [`ssl-key`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#ssl-key) 定义。

</CustomContent>

### system_time_zone

- 范围：无
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：（系统相关）
- 此变量显示 TiDB 首次启动时的系统时区。另请参阅 [`time_zone`](#time_zone)。

### tidb_adaptive_closest_read_threshold <span class="version-mark">v6.3.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`4096`
- 范围：`[0, 9223372036854775807]`
- 单位：字节
- 此变量用于控制当 [`tidb_replica_read`](#tidb_replica_read-new-in-v40) 设置为 `closest-adaptive` 时，TiDB 服务器倾向于将读取请求发送到与 TiDB 服务器位于同一可用区中的副本的阈值。如果估计结果高于或等于此阈值，TiDB 倾向于将读取请求发送到同一可用区中的副本。否则，TiDB 将读取请求发送到 leader 副本。

### tidb_allow_tiflash_cop <span class="version-mark">v7.3.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`
- 当 TiDB 将计算任务下推到 TiFlash 时，有三种方法（或协议）可供选择：Cop、BatchCop 和 MPP。与 Cop 和 BatchCop 相比，MPP 协议更成熟，并提供更好的任务和资源管理。因此，建议使用 MPP 协议。
    - `0` 或 `OFF`：优化器仅生成使用 TiFlash MPP 协议的计划。
    - `1` 或 `ON`：优化器根据成本估算确定是使用 Cop、BatchCop 还是 MPP 协议来生成执行计划。

### tidb_allow_batch_cop <span class="version-mark">v4.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：整数
- 默认值：`1`
- 范围：`[0, 2]`
- 此变量用于控制 TiDB 如何将 coprocessor 请求发送到 TiFlash。它具有以下值：

    * `0`：从不批量发送请求
    * `1`：聚合和连接请求批量发送
    * `2`：所有 coprocessor 请求批量发送

### tidb_allow_fallback_to_tikv <span class="version-mark">v5.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：""
- 此变量用于指定可能回退到 TiKV 的存储引擎列表。如果 SQL 语句的执行由于列表中指定的存储引擎发生故障而失败，TiDB 会使用 TiKV 重试执行此 SQL 语句。此变量可以设置为 "" 或 "tiflash"。当此变量设置为 "tiflash" 时，如果 TiFlash 返回超时错误（错误代码：ErrTiFlashServerTimeout），TiDB 会使用 TiKV 重试执行此 SQL 语句。

### tidb_allow_function_for_expression_index <span class="version-mark">v5.2.0 新增</span>

- 范围：无
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`json_array, json_array_append, json_array_insert, json_contains, json_contains_path, json_depth, json_extract, json_insert, json_keys, json_length, json_merge_patch, json_merge_preserve, json_object, json_pretty, json_quote, json_remove, json_replace, json_search, json_set, json_storage_size, json_type, json_unquote, json_valid, lower, md5, reverse, tidb_shard, upper, vitess_hash`
- 此只读变量用于显示允许用于创建[表达式索引](/sql-statements/sql-statement-create-index.md#expression-index)的函数。

### tidb_allow_mpp <span class="version-mark">v5.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔值
- 默认值：`ON`
- 控制是否使用 TiFlash 的 MPP 模式来执行查询。值选项如下：
    - `0` 或 `OFF`，表示不使用 MPP 模式。对于 v7.3.0 或更高版本，如果将此变量的值设置为 `0` 或 `OFF`，还需要启用 [`tidb_allow_tiflash_cop`](/system-variables.md#tidb_allow_tiflash_cop-new-in-v730) 变量。否则，查询可能会返回错误。
    - `1` 或 `ON`，表示优化器根据成本估算（默认）确定是否使用 MPP 模式。

MPP 是 TiFlash 引擎提供的分布式计算框架，允许节点之间的数据交换，并提供高性能、高吞吐量的 SQL 算法。有关 MPP 模式选择的详细信息，请参阅[控制是否选择 MPP 模式](/tiflash/use-tiflash-mpp-mode.md#control-whether-to-select-the-mpp-mode)。

### tidb_allow_remove_auto_inc <span class="version-mark">v2.1.18 和 v3.0.4 新增</span>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

- 范围：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`
- 此变量用于设置是否允许通过执行 `ALTER TABLE MODIFY` 或 `ALTER TABLE CHANGE` 语句删除列的 `AUTO_INCREMENT` 属性。默认情况下不允许。

### tidb_analyze_distsql_scan_concurrency <span class="version-mark">v7.6.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`4`
- 范围：`[1, 4294967295]`
- 此变量用于设置执行 `ANALYZE` 操作时 `scan` 操作的并发度。

### tidb_analyze_partition_concurrency

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`2`。对于 v7.4.0 及更早版本，默认值为 `1`。
- 此变量指定 TiDB 分析分区表时，读取和写入分区表的统计信息的并发度。

### tidb_analyze_version <span class="version-mark">v5.1.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`2`
- 范围：`[1, 2]`
- 控制 TiDB 如何收集统计信息。
    - 对于 TiDB Self-Managed，从 v5.3.0 开始，此变量的默认值从 `1` 更改为 `2`。
    - 对于 TiDB Cloud，从 v6.5.0 开始，此变量的默认值从 `1` 更改为 `2`。
    - 如果您的集群是从早期版本升级的，则升级后 `tidb_analyze_version` 的默认值不会更改。
- 有关此变量的详细介绍，请参见[统计信息介绍](/statistics.md)。

### tidb_analyze_skip_column_types <span class="version-mark">v7.2.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值："json,blob,mediumblob,longblob"