- 此变量用于控制是否可以使用 `DOUBLE` 类型的无效定义创建表。此设置旨在提供从早期 TiDB 版本升级的途径，因为早期版本在验证类型方面不太严格。
- 默认值 `ON` 与 MySQL 兼容。

例如，类型 `DOUBLE(10)` 现在被认为是无效的，因为浮点类型的精度无法保证。将 `tidb_enable_strict_double_type_check` 更改为 `OFF` 后，表将被创建：

```sql
mysql> CREATE TABLE t1 (id int, c double(10));
ERROR 1149 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use

mysql> SET tidb_enable_strict_double_type_check = 'OFF';
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE TABLE t1 (id int, c double(10));
Query OK, 0 rows affected (0.09 sec)
```

> **注意：**
>
> 此设置仅适用于 `DOUBLE` 类型，因为 MySQL 允许 `FLOAT` 类型的精度。从 MySQL 8.0.17 开始，此行为已被弃用，不建议为 `FLOAT` 或 `DOUBLE` 类型指定精度。

### tidb_enable_table_partition

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`ON`
- 可选值：`OFF`，`ON`，`AUTO`
- 此变量用于设置是否启用 `TABLE PARTITION` 功能：
    - `ON` 表示启用 Range 分区、Hash 分区和单列 Range 列分区。
    - `AUTO` 的功能与 `ON` 相同。
    - `OFF` 表示禁用 `TABLE PARTITION` 功能。在这种情况下，可以执行创建分区表的语法，但创建的表不是分区表。

### tidb_enable_telemetry <span class="version-mark">v4.0.2 新增，v8.1.0 弃用</span>

> **警告：**
>
> 从 v8.1.0 开始，TiDB 中的遥测功能已移除，此变量不再起作用。保留此变量仅是为了与早期版本兼容。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`

<CustomContent platform="tidb">

- 在 v8.1.0 之前，此变量控制是否启用 TiDB 中的遥测收集。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

### tidb_enable_tiflash_read_for_write_stmt <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`ON`
- 此变量控制包含 `INSERT`、`DELETE` 和 `UPDATE` 的 SQL 语句中的读取操作是否可以下推到 TiFlash。例如：

    - `INSERT INTO SELECT` 语句中的 `SELECT` 查询（典型使用场景：[TiFlash 查询结果物化](/tiflash/tiflash-results-materialization.md)）
    - `UPDATE` 和 `DELETE` 语句中的 `WHERE` 条件过滤
- 从 v7.1.0 开始，此变量已被弃用。当 [`tidb_allow_mpp = ON`](/system-variables.md#tidb_allow_mpp-new-in-v50) 时，优化器会根据 [SQL 模式](/sql-mode.md) 和 TiFlash 副本的成本估算智能地决定是否将查询下推到 TiFlash。请注意，仅当当前会话的 [SQL 模式](/sql-mode.md) 不是严格模式时，TiDB 才允许将包含 `INSERT`、`DELETE` 和 `UPDATE` 的 SQL 语句（例如 `INSERT INTO SELECT`）中的读取操作下推到 TiFlash，这意味着 `sql_mode` 值不包含 `STRICT_TRANS_TABLES` 和 `STRICT_ALL_TABLES`。

### tidb_enable_top_sql <span class="version-mark">v5.4.0 新增</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`

<CustomContent platform="tidb">

- 此变量用于控制是否启用 [Top SQL](/dashboard/top-sql.md) 功能。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于控制是否启用 [Top SQL](https://docs.pingcap.com/tidb/stable/top-sql) 功能。

</CustomContent>

### tidb_enable_tso_follower_proxy <span class="version-mark">v5.3.0 新增</span>

> **注意：**
>
> 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless)，此变量是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`
- 此变量控制是否启用 TSO Follower Proxy 功能。当值为 `OFF` 时，TiDB 仅从 PD leader 获取 TSO。当值为 `ON` 时，TiDB 将 TSO 请求均匀地分配给所有 PD 服务器，PD follower 也可以处理 TSO 请求，从而降低 PD leader 的 CPU 压力。
- 启用 TSO Follower Proxy 的场景：
    * 由于 TSO 请求压力过大，PD leader 的 CPU 达到瓶颈，导致 TSO RPC 请求的延迟较高。
    * TiDB 集群有许多 TiDB 实例，并且增加 [`tidb_tso_client_batch_max_wait_time`](#tidb_tso_client_batch_max_wait_time-new-in-v530) 的值无法缓解 TSO RPC 请求的高延迟问题。

> **注意：**
>
> 假设 TSO RPC 延迟增加的原因不是 PD leader 的 CPU 使用率瓶颈（例如网络问题）。在这种情况下，启用 TSO Follower Proxy 可能会增加 TiDB 中的执行延迟并影响集群的 QPS 性能。

### tidb_enable_unsafe_substitute <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`
- 此变量控制是否以不安全的方式将表达式替换为生成列。默认值为 `OFF`，表示默认禁用不安全替换。有关更多详细信息，请参见 [生成列](/generated-columns.md)。

### tidb_enable_vectorized_expression <span class="version-mark">v4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔值
- 默认值：`ON`
- 此变量用于控制是否启用向量化执行。

### tidb_enable_window_function

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`ON`
- 此变量用于控制是否启用对 [窗口函数](/functions-and-operators/window-functions.md) 的支持。请注意，窗口函数可能会使用保留关键字。这可能会导致原本可以正常执行的 SQL 语句在 TiDB 升级后无法解析。在这种情况下，您可以将 `tidb_enable_window_function` 设置为 `OFF`。

### `tidb_enable_row_level_checksum` <span class="version-mark">v7.1.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`

<CustomContent platform="tidb">

- 此变量用于控制是否启用 [TiCDC 单行数据的数据完整性验证](/ticdc/ticdc-integrity-check.md) 功能。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量用于控制是否启用 [TiCDC 单行数据的数据完整性验证](https://docs.pingcap.com/tidb/stable/ticdc-integrity-check) 功能。

</CustomContent>