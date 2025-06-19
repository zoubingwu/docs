- 值选项：`PRIORITY_LOW`，`PRIORITY_NORMAL`，`PRIORITY_HIGH`
- 此变量用于设置在 `re-organize` 阶段执行 `ADD INDEX` 操作的优先级。
- 您可以将此变量的值设置为 `PRIORITY_LOW`、`PRIORITY_NORMAL` 或 `PRIORITY_HIGH`。

### tidb_ddl_reorg_worker_cnt

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`4`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置 `re-organize` 阶段 DDL 操作的并发度。

### `tidb_enable_fast_create_table` <span class="version-mark">v8.0.0 新增</span>

> **警告：**
>
> 此变量目前是一项实验性功能，不建议在生产环境中使用。此功能可能会更改或删除，恕不另行通知。如果您发现错误，请在 GitHub 上提出 [issue](https://github.com/pingcap/tidb/issues) 进行反馈。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于控制是否启用 [TiDB 加速建表](/accelerated-table-creation.md)。
- 从 v8.0.0 开始，TiDB 支持使用 `tidb_enable_fast_create_table` 通过 [`CREATE TABLE`](/sql-statements/sql-statement-create-table.md) 语句加速建表。
- 此变量是从 v7.6.0 中引入的变量 [`tidb_ddl_version`](https://docs.pingcap.com/tidb/v7.6/system-variables#tidb_ddl_version-new-in-v760) 重命名的。从 v8.0.0 开始，`tidb_ddl_version` 不再生效。

### tidb_default_string_match_selectivity <span class="version-mark">v6.2.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Float
- 默认值：`0.8`
- 范围：`[0, 1]`
- 此变量用于设置在估计行数时，过滤器条件中 `like`、`rlike` 和 `regexp` 函数的默认选择性。此变量还控制是否启用 TopN 来帮助估计这些函数。
- TiDB 尝试使用统计信息来估计过滤器条件中的 `like`。但是，当 `like` 匹配复杂的字符串，或者使用 `rlike` 或 `regexp` 时，TiDB 通常无法完全使用统计信息，而是将默认值 `0.8` 设置为选择性比率，从而导致不准确的估计。
- 此变量用于更改上述行为。如果将该变量设置为 `0` 以外的值，则选择性比率是指定的变量值，而不是 `0.8`。
- 如果将该变量设置为 `0`，TiDB 会尝试使用统计信息中的 TopN 进行评估，以提高准确性，并在估计上述三个函数时考虑统计信息中的 NULL 数量。前提是在 [`tidb_analyze_version`](#tidb_analyze_version-new-in-v510) 设置为 `2` 时收集统计信息。这种评估可能会稍微影响性能。
- 如果将该变量设置为 `0.8` 以外的值，TiDB 会相应地调整对 `not like`、`not rlike` 和 `not regexp` 的估计。

### tidb_disable_txn_auto_retry

> **警告：**
>
> 从 v8.0.0 开始，此变量已弃用，TiDB 不再支持乐观事务的自动重试。作为替代方案，当遇到乐观事务冲突时，您可以在应用程序中捕获错误并重试事务，或者改用 [悲观事务模式](/pessimistic-transaction.md)。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于设置是否禁用显式乐观事务的自动重试。默认值 `ON` 表示事务不会在 TiDB 中自动重试，并且 `COMMIT` 语句可能会返回需要在应用程序层处理的错误。

    将值设置为 `OFF` 表示 TiDB 将自动重试事务，从而减少 `COMMIT` 语句中的错误。更改此设置时要小心，因为它可能会导致更新丢失。

    此变量不影响自动提交的隐式事务和 TiDB 中内部执行的事务。这些事务的最大重试次数由 `tidb_retry_limit` 的值决定。

    有关更多详细信息，请参见 [重试限制](/optimistic-transaction.md#limits-of-retry)。

    <CustomContent platform="tidb">

    此变量仅适用于乐观事务，不适用于悲观事务。悲观事务的重试次数由 [`max_retry_count`](/tidb-configuration-file.md#max-retry-count) 控制。

    </CustomContent>

    <CustomContent platform="tidb-cloud">

    此变量仅适用于乐观事务，不适用于悲观事务。悲观事务的重试次数为 256。

    </CustomContent>

### tidb_distsql_scan_concurrency

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`15`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置 `scan` 操作的并发度。
- 在 OLAP 场景中使用较大的值，在 OLTP 场景中使用较小的值。
- 对于 OLAP 场景，最大值不应超过所有 TiKV 节点的 CPU 核心数。
- 如果表有很多分区，您可以适当减小变量值（由要扫描的数据大小和扫描频率决定），以避免 TiKV 内存不足 (OOM)。
- 对于只有 `LIMIT` 子句的简单查询，如果 `LIMIT` 值小于 100000，则下推到 TiKV 的扫描操作会将此变量的值视为 `1`，以提高执行效率。
- 对于 `SELECT MAX/MIN(col) FROM ...` 查询，如果 `col` 列具有以 `MAX(col)` 或 `MIN(col)` 函数所需的相同顺序排序的索引，TiDB 会将查询重写为 `SELECT col FROM ... LIMIT 1` 进行处理，并且此变量的值也将被处理为 `1`。例如，对于 `SELECT MIN(col) FROM ...`，如果 `col` 列具有升序索引，TiDB 可以通过将查询重写为 `SELECT col FROM ... LIMIT 1` 并直接读取索引的第一行来快速获得 `MIN(col)` 值。

### tidb_dml_batch_size

> **警告：**
>
> 此变量与已弃用的 batch-dml 功能相关联，该功能可能会导致数据损坏。因此，不建议为 batch-dml 启用此变量。而是使用 [非事务性 DML](/non-transactional-dml.md)。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 2147483647]`
- 单位：行
- 当此值大于 `0` 时，TiDB 会将 `INSERT` 等语句批量提交到较小的事务中。这减少了内存使用量，并有助于确保批量修改不会达到 `txn-total-size-limit`。
- 只有值 `0` 提供 ACID 兼容性。将此值设置为任何其他值将破坏 TiDB 的原子性和隔离性保证。
- 要使此变量生效，您还需要启用 `tidb_enable_batch_dml` 和 `tidb_batch_insert` 和 `tidb_batch_delete` 中的至少一个。

> **注意：**
>
> 从 v7.0.0 开始，`tidb_dml_batch_size` 不再对 [`LOAD DATA` 语句](/sql-statements/sql-statement-load-data.md) 生效。

### tidb_dml_type <span class="version-mark">v8.0.0 新增</span>

> **警告：**
>