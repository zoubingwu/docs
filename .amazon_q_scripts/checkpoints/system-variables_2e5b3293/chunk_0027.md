- 新启动的 TiFlash 节点不提供服务。为了防止查询失败，TiDB 限制 tidb-server 向新启动的 TiFlash 节点发送查询。此变量指示新启动的 TiFlash 节点不发送请求的时间范围。

### tidb_multi_statement_mode <span class="version-mark">v4.0.11 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`OFF`
- 可选值：`OFF`，`ON`，`WARN`
- 此变量控制是否允许在同一个 `COM_QUERY` 调用中执行多个查询。
- 为了减少 SQL 注入攻击的影响，TiDB 默认情况下会阻止在同一个 `COM_QUERY` 调用中执行多个查询。此变量旨在用作从早期 TiDB 版本升级路径的一部分。以下行为适用：

| 客户端设置            | `tidb_multi_statement_mode` 值 | 允许多个语句吗？ |
| ------------------------- | --------------------------------- | ------------------------------ |
| Multiple Statements = ON  | OFF                               | 是                            |
| Multiple Statements = ON  | ON                                | 是                            |
| Multiple Statements = ON  | WARN                              | 是                            |
| Multiple Statements = OFF | OFF                               | 否                             |
| Multiple Statements = OFF | ON                                | 是                            |
| Multiple Statements = OFF | WARN                              | 是 (+ 返回警告)        |

> **注意：**
>
> 只有默认值 `OFF` 才能被认为是安全的。如果您的应用程序是专门为早期版本的 TiDB 设计的，则可能需要设置 `tidb_multi_statement_mode=ON`。如果您的应用程序需要多语句支持，建议使用客户端库提供的设置，而不是 `tidb_multi_statement_mode` 选项。例如：
>
> * [go-sql-driver](https://github.com/go-sql-driver/mysql#multistatements) (`multiStatements`)
> * [Connector/J](https://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html) (`allowMultiQueries`)
> * PHP [mysqli](https://www.php.net/manual/en/mysqli.quickstart.multiple-statement.php) (`mysqli_multi_query`)

### tidb_nontransactional_ignore_error <span class="version-mark">v6.1.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔
- 默认值：`OFF`
- 此变量指定在非事务 DML 语句中发生错误时是否立即返回错误。
- 当该值设置为 `OFF` 时，非事务 DML 语句在第一个错误处立即停止并返回错误。所有后续批次都将被取消。
- 当该值设置为 `ON` 并且批处理中发生错误时，后续批处理将继续执行，直到所有批处理都执行完毕。执行过程中发生的所有错误将一起在结果中返回。

### tidb_opt_agg_push_down

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔
- 默认值：`OFF`
- 此变量用于设置优化器是否执行将聚合函数下推到 Join、Projection 和 UnionAll 之前位置的优化操作。
- 当查询中的聚合操作速度较慢时，可以将变量值设置为 ON。

### tidb_opt_broadcast_cartesian_join

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：整数
- 默认值：`1`
- 范围：`[0, 2]`
- 指示是否允许 Broadcast Cartesian Join。
- `0` 表示不允许 Broadcast Cartesian Join。`1` 表示基于 [`tidb_broadcast_join_threshold_count`](#tidb_broadcast_join_threshold_count-new-in-v50) 允许。`2` 表示始终允许，即使表大小超过阈值。
- 此变量在 TiDB 内部使用，**不**建议修改其值。

### tidb_opt_concurrency_factor

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：浮点数
- 范围：`[0, 18446744073709551615]`
- 默认值：`3.0`
- 表示在 TiDB 中启动 Golang goroutine 的 CPU 成本。此变量在 [成本模型](/cost-model.md) 内部使用，**不**建议修改其值。

### tidb_opt_copcpu_factor

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：浮点数
- 范围：`[0, 18446744073709551615]`
- 默认值：`3.0`
- 表示 TiKV Coprocessor 处理一行数据的 CPU 成本。此变量在 [成本模型](/cost-model.md) 内部使用，**不**建议修改其值。

### tidb_opt_correlation_exp_factor

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：整数
- 默认值：`1`
- 范围：`[0, 2147483647]`
- 当基于列顺序相关性估计行数的方法不可用时，将使用启发式估计方法。此变量用于控制启发式方法的行为。
    - 当值为 0 时，不使用启发式方法。
    - 当值大于 0 时：
        - 值越大，表示启发式方法中可能使用索引扫描。
        - 值越小，表示启发式方法中可能使用表扫描。

### tidb_opt_correlation_threshold

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：浮点数
- 默认值：`0.9`
- 范围：`[0, 1]`
- 此变量用于设置阈值，该阈值确定是否启用使用列顺序相关性估计行数。如果当前列与 `handle` 列之间的顺序相关性超过阈值，则启用此方法。

### tidb_opt_cpu_factor

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：浮点数
- 范围：`[0, 2147483647]`
- 默认值：`3.0`
- 表示 TiDB 处理一行数据的 CPU 成本。此变量在 [成本模型](/cost-model.md) 内部使用，**不**建议修改其值。

### `tidb_opt_derive_topn` <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔
- 默认值：`OFF`
- 控制是否启用 [从窗口函数推导 TopN 或 Limit](/derive-topn-from-window.md) 的优化规则。

### tidb_opt_desc_factor

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：浮点数
- 范围：`[0, 18446744073709551615]`
- 默认值：`3.0`
- 表示 TiKV 以降序扫描磁盘中一行数据的成本。此变量在 [成本模型](/cost-model.md) 内部使用，**不**建议修改其值。

### tidb_opt_disk_factor

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：浮点数
- 范围：`[0, 18446744073709551615]`
- 默认值：`1.5`