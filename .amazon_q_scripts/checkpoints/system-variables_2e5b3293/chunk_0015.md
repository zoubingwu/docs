- 自 v5.4.0 起，对于新部署的 TiDB 集群，默认启用此变量。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制是否启用索引合并功能。

### tidb_enable_index_merge_join

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 指定是否启用 `IndexMergeJoin` 算子。
- 此变量仅用于 TiDB 的内部操作。**不建议**调整它。否则，可能会影响数据的正确性。

### tidb_enable_legacy_instance_scope <span class="version-mark">v6.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量允许使用 `SET SESSION` 以及 `SET GLOBAL` 语法来设置 `INSTANCE` 作用域的变量。
- 默认启用此选项是为了与早期版本的 TiDB 兼容。

### tidb_enable_list_partition <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于设置是否启用 `LIST (COLUMNS) TABLE PARTITION` 功能。

### tidb_enable_local_txn

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于尚未发布的功能。**请勿更改变量值**。

### tidb_enable_metadata_lock <span class="version-mark">v6.3.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于设置是否启用 [Metadata lock](/metadata-lock.md) 功能。请注意，在设置此变量时，需要确保集群中没有正在运行的 DDL 语句。否则，数据可能不正确或不一致。

### tidb_enable_mutation_checker <span class="version-mark">v6.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于控制是否启用 TiDB mutation checker，该工具用于检查 DML 语句执行期间数据和索引之间的一致性。如果 checker 为某个语句返回错误，TiDB 会回滚该语句的执行。启用此变量会导致 CPU 使用率略有增加。有关更多信息，请参见 [解决数据和索引不一致问题](/troubleshoot-data-inconsistency-errors.md)。
- 对于 v6.0.0 或更高版本的新集群，默认值为 `ON`。对于从早于 v6.0.0 的版本升级的现有集群，默认值为 `OFF`。

### tidb_enable_new_cost_interface <span class="version-mark">v6.2.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- TiDB v6.2.0 重构了之前成本模型的实现。此变量控制是否启用重构后的成本模型实现。
- 默认启用此变量，因为重构后的成本模型使用与之前相同的成本公式，这不会改变计划决策。
- 如果您的集群是从 v6.1 升级到 v6.2，则此变量保持 `OFF`，建议手动启用它。如果您的集群是从早于 v6.1 的版本升级的，则默认情况下此变量设置为 `ON`。

### tidb_enable_new_only_full_group_by_check <span class="version-mark">v6.1.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制 TiDB 执行 `ONLY_FULL_GROUP_BY` 检查时的行为。有关 `ONLY_FULL_GROUP_BY` 的详细信息，请参阅 [MySQL 文档](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sqlmode_only_full_group_by)。在 v6.1.0 中，TiDB 更严格和正确地处理此检查。
- 为了避免版本升级可能导致的兼容性问题，此变量在 v6.1.0 中的默认值为 `OFF`。

### tidb_enable_noop_functions <span class="version-mark">v4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`OFF`
- 可能的值：`OFF`、`ON`、`WARN`
- 默认情况下，当您尝试使用尚未实现的功能的语法时，TiDB 会返回错误。当变量值设置为 `ON` 时，TiDB 会静默地忽略此类不可用功能的情况，如果您无法更改 SQL 代码，这将很有帮助。
- 启用 `noop` 函数控制以下行为：
    * `LOCK IN SHARE MODE` 语法
    * `SQL_CALC_FOUND_ROWS` 语法
    * `START TRANSACTION READ ONLY` 和 `SET TRANSACTION READ ONLY` 语法
    * `tx_read_only`、`transaction_read_only`、`offline_mode`、`super_read_only`、`read_only` 和 `sql_auto_is_null` 系统变量
    * `GROUP BY <expr> ASC|DESC` 语法

> **警告：**
>
> 只有默认值 `OFF` 才能被认为是安全的。设置 `tidb_enable_noop_functions=1` 可能会导致应用程序中出现意外行为，因为它允许 TiDB 忽略某些语法而不提供错误。例如，允许使用语法 `START TRANSACTION READ ONLY`，但事务仍处于读写模式。

### tidb_enable_noop_variables <span class="version-mark">v6.2.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 如果您将变量值设置为 `OFF`，TiDB 的行为如下：
    * 当您使用 `SET` 设置 `noop` 变量时，TiDB 返回 `“setting *variable_name* has no effect in TiDB”` 警告。
    * `SHOW [SESSION | GLOBAL] VARIABLES` 的结果不包括 `noop` 变量。
    * 当您使用 `SELECT` 读取 `noop` 变量时，TiDB 返回 `“variable *variable_name* has no effect in TiDB”` 警告。
- 要检查 TiDB 实例是否已设置和读取 `noop` 变量，可以使用 `SELECT * FROM INFORMATION_SCHEMA.CLIENT_ERRORS_SUMMARY_GLOBAL;` 语句。

### tidb_enable_null_aware_anti_join <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：在 v7.0.0 之前，默认值为 `OFF`。从 v7.0.0 开始，默认值为 `ON`。
- 类型：Boolean
- 此变量控制当由特殊集合运算符 `NOT IN` 和 `!= ALL` 引导的子查询生成 ANTI JOIN 时，TiDB 是否应用 Null Aware Hash Join。
- 当您从早期版本升级到 v7.0.0 或更高版本的集群时，该功能会自动启用，这意味着此变量设置为 `ON`。

### tidb_enable_outer_join_reorder <span class="version-mark">v6.1.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Boolean
- 默认值：`ON`