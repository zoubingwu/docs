- 此变量用于设置 TiDB 在当前会话中可以读取的历史数据的时间范围。设置该值后，TiDB 会从该变量允许的范围内选择一个尽可能新的时间戳，并且所有后续的读取操作都将针对该时间戳执行。例如，如果此变量的值设置为 `-5`，在 TiKV 具有相应历史版本数据的前提下，TiDB 将在 5 秒的时间范围内选择一个尽可能新的时间戳。

### tidb_record_plan_in_slow_log

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制是否将慢查询的执行计划包含在慢日志中。

### tidb_redact_log

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`OFF`
- 可选值：`OFF`，`ON`，`MARKER`
- 此变量控制是否隐藏记录到 TiDB 日志和慢日志中的 SQL 语句中的用户信息。
- 默认值为 `OFF`，表示不对用户信息进行任何处理。
- 当您将变量设置为 `ON` 时，用户信息将被隐藏。例如，如果执行的 SQL 语句是 `INSERT INTO t VALUES (1,2)`，则该语句在日志中记录为 `INSERT INTO t VALUES (?,?)`。
- 当您将变量设置为 `MARKER` 时，用户信息将用 `‹ ›` 包裹。例如，如果执行的 SQL 语句是 `INSERT INTO t VALUES (1,2)`，则该语句在日志中记录为 `INSERT INTO t VALUES (‹1›,‹2›)`。如果输入包含 `‹`，则转义为 `‹‹`，`›` 转义为 `››`。基于标记的日志，您可以决定在显示日志时是否对标记的信息进行脱敏。

### tidb_regard_null_as_point <span class="version-mark">v5.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制优化器是否可以使用包含 null 等价的查询条件作为索引访问的前缀条件。
- 默认情况下启用此变量。启用后，优化器可以减少要访问的索引数据量，从而加快查询执行速度。例如，如果查询涉及多列索引 `index(a, b)` 并且查询条件包含 `a<=>null and b=1`，则优化器可以使用查询条件中的 `a<=>null` 和 `b=1` 进行索引访问。如果禁用该变量，由于 `a<=>null and b=1` 包含 null 等价条件，优化器将不使用 `b=1` 进行索引访问。

### tidb_remove_orderby_in_subquery <span class="version-mark">v6.1.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：v7.2.0 之前的默认值为 `OFF`。 从 v7.2.0 开始，默认值为 `ON`。
- 指定是否删除子查询中的 `ORDER BY` 子句。
- 在 ISO/IEC SQL 标准中，`ORDER BY` 主要用于对顶级查询的结果进行排序。 对于子查询，该标准不要求结果按 `ORDER BY` 排序。
- 要对子查询结果进行排序，通常可以在外部查询中处理它，例如使用窗口函数或在外部查询中再次使用 `ORDER BY`。 这样做可以确保最终结果集的顺序。

### tidb_replica_read <span class="version-mark">v4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Enumeration
- 默认值：`leader`
- 可选值：`leader`、`follower`、`leader-and-follower`、`prefer-leader`、`closest-replicas`、`closest-adaptive` 和 `learner`。 `learner` 值在 v6.6.0 中引入。
- 此变量用于控制 TiDB 从哪里读取数据。
- 有关用法和实现的更多详细信息，请参见 [Follower read](/follower-read.md)。

### tidb_restricted_read_only <span class="version-mark">v5.2.0 新增</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- `tidb_restricted_read_only` 和 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531) 的行为类似。 在大多数情况下，您应该只使用 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531)。
- 具有 `SUPER` 或 `SYSTEM_VARIABLES_ADMIN` 权限的用户可以修改此变量。 但是，如果启用了 [安全增强模式](#tidb_enable_enhanced_security)，则需要额外的 `RESTRICTED_VARIABLES_ADMIN` 权限才能读取或修改此变量。
- `tidb_restricted_read_only` 在以下情况下会影响 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531)：
    - 将 `tidb_restricted_read_only` 设置为 `ON` 会将 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531) 更新为 `ON`。
    - 将 `tidb_restricted_read_only` 设置为 `OFF` 不会更改 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531)。
    - 如果 `tidb_restricted_read_only` 为 `ON`，则无法将 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531) 设置为 `OFF`。
- 对于 TiDB 的 DBaaS 提供商，如果 TiDB 集群是另一个数据库的下游数据库，为了使 TiDB 集群只读，您可能需要启用 [安全增强模式](#tidb_enable_enhanced_security) 来使用 `tidb_restricted_read_only`，这可以防止您的客户使用 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531) 使集群可写。 为此，您需要启用 [安全增强模式](#tidb_enable_enhanced_security)，使用具有 `SYSTEM_VARIABLES_ADMIN` 和 `RESTRICTED_VARIABLES_ADMIN` 权限的管理员用户来控制 `tidb_restricted_read_only`，并让您的数据库用户使用具有 `SUPER` 权限的 root 用户来仅控制 [`tidb_super_read_only`](#tidb_super_read_only-new-in-v531)。
- 此变量控制整个集群的只读状态。 当变量为 `ON` 时，整个集群中的所有 TiDB 服务器都处于只读模式。 在这种情况下，TiDB 仅执行不修改数据的语句，例如 `SELECT`、`USE` 和 `SHOW`。 对于其他语句（例如 `INSERT` 和 `UPDATE`），TiDB 会拒绝在只读模式下执行这些语句。
- 使用此变量启用只读模式只能确保整个集群最终进入只读状态。 如果您已更改 TiDB 集群中此变量的值，但该更改尚未传播到其他 TiDB 服务器，则未更新的 TiDB 服务器仍然**不**处于只读模式。
- TiDB 在执行 SQL 语句之前检查只读标志。 从 v6.2.0 开始，在提交 SQL 语句之前也会检查该标志。 这有助于防止长时间运行的 [自动提交](/transaction-overview.md#autocommit) 语句在服务器置于只读模式后可能修改数据的情况。
- 启用此变量后，TiDB 按以下方式处理未提交的事务：
    - 对于未提交的只读事务，您可以正常提交事务。
    - 对于未提交的非只读事务，将拒绝在这些事务中执行写操作的 SQL 语句。
    - 对于具有修改数据的未提交的只读事务，将拒绝提交这些事务。