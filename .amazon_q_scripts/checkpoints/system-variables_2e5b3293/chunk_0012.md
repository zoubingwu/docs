批量 DML 执行模式 (`tidb_dml_type = "bulk"`) 是一项实验性功能。不建议在生产环境中使用。此功能可能会更改或删除，恕不另行通知。如果您发现错误，可以报告 [issue](https://github.com/pingcap/tidb/issues)。在当前版本中，当 TiDB 使用批量 DML 模式执行大型事务时，可能会影响 TiCDC、TiFlash 和 TiKV 的 resolved-ts 模块的内存使用和执行效率，并可能导致 OOM 问题。此外，BR 可能会被阻塞，并且在遇到锁时无法处理。因此，不建议在启用这些组件或功能时使用此模式。

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：String
- 默认值：`"standard"`
- 可选值：`"standard"`, `"bulk"`
- 此变量控制 DML 语句的执行模式。
    - `"standard"` 表示标准 DML 执行模式，其中 TiDB 事务在提交之前缓存在内存中。此模式适用于具有潜在冲突的高并发事务场景，是默认推荐的执行模式。
    - `"bulk"` 表示批量 DML 执行模式，适用于写入大量数据导致 TiDB 内存使用过多的场景。
        - 在 TiDB 事务执行期间，数据不会完全缓存在 TiDB 内存中，而是持续写入 TiKV 以减少内存使用并平滑写入压力。
        - 只有 `INSERT`、`UPDATE`、`REPLACE` 和 `DELETE` 语句受 `"bulk"` 模式影响。由于 `"bulk"` 模式下的流水线式执行，当更新导致冲突时，使用 `INSERT IGNORE ... ON DUPLICATE UPDATE ...` 可能会导致 `Duplicate entry` 错误。 相比之下，在 `"standard"` 模式下，由于设置了 `IGNORE` 关键字，此错误将被忽略，不会返回给用户。
        - `"bulk"` 模式仅适用于**写入大量数据且没有冲突**的场景。此模式对于处理写入冲突效率不高，因为写入-写入冲突可能导致大型事务失败并回滚。
        - `"bulk"` 模式仅对启用自动提交的语句生效，并且需要将 [`pessimistic-auto-commit`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#pessimistic-auto-commit-new-in-v600) 配置项设置为 `false`。
        - 使用 `"bulk"` 模式执行语句时，请确保在执行过程中 [metadata lock](/metadata-lock.md) 保持启用状态。
        - `"bulk"` 模式不能用于 [临时表](/temporary-tables.md) 和 [缓存表](/cached-tables.md)。
        - 当外键约束检查启用 (`foreign_key_checks = ON`) 时，`"bulk"` 模式不能用于包含外键的表和被外键引用的表。
        - 在环境不支持或与 `"bulk"` 模式不兼容的情况下，TiDB 会回退到 `"standard"` 模式并返回警告消息。要验证是否使用了 `"bulk"` 模式，可以使用 [`tidb_last_txn_info`](#tidb_last_txn_info-new-in-v409) 检查 `pipelined` 字段。`true` 值表示使用了 `"bulk"` 模式。
        - 在 `"bulk"` 模式下执行大型事务时，事务持续时间可能会很长。对于此模式下的事务，事务锁的最大 TTL 是 [`max-txn-ttl`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#max-txn-ttl) 和 24 小时之间的较大值。此外，如果事务执行时间超过了 [`tidb_gc_max_wait_time`](#tidb_gc_max_wait_time-new-in-v610) 设置的值，GC 可能会强制回滚事务，导致事务失败。
        - 当 TiDB 在 `"bulk"` 模式下执行事务时，事务大小不受 TiDB 配置项 [`txn-total-size-limit`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#txn-total-size-limit) 的限制。
        - 此模式由 Pipelined DML 功能实现。有关详细设计和 GitHub issue，请参阅 [Pipelined DML](https://github.com/pingcap/tidb/blob/release-8.1/docs/design/2024-01-09-pipelined-DML.md) 和 [#50215](https://github.com/pingcap/tidb/issues/50215)。

### tidb_enable_1pc <span class="version-mark">New in v5.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于指定是否为仅影响一个 Region 的事务启用单阶段提交功能。与常用的两阶段提交相比，单阶段提交可以大大减少事务提交的延迟并提高吞吐量。

> **注意：**
>
> - 默认值 `ON` 仅适用于新集群。如果您的集群是从早期版本的 TiDB 升级而来，则将使用值 `OFF`。
> - 如果您已启用 TiDB Binlog，则启用此变量无法提高性能。为了提高性能，建议使用 [TiCDC](https://docs.pingcap.com/tidb/stable/ticdc-overview) 代替。
> - 启用此参数仅意味着单阶段提交成为事务提交的可选模式。实际上，最合适的事务提交模式由 TiDB 决定。

### tidb_enable_analyze_snapshot <span class="version-mark">New in v6.2.0</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量控制执行 `ANALYZE` 时是读取历史数据还是最新数据。如果此变量设置为 `ON`，则 `ANALYZE` 读取 `ANALYZE` 时可用的历史数据。如果此变量设置为 `OFF`，则 `ANALYZE` 读取最新数据。
- 在 v5.2 之前，`ANALYZE` 读取最新数据。从 v5.2 到 v6.1，`ANALYZE` 读取 `ANALYZE` 时可用的历史数据。

> **警告：**
>
> 如果 `ANALYZE` 读取 `ANALYZE` 时可用的历史数据，则 `AUTO ANALYZE` 的长时间运行可能会导致 `GC life time is shorter than transaction duration` 错误，因为历史数据已被垃圾回收。

### tidb_enable_async_commit <span class="version-mark">New in v5.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制是否启用异步提交功能，以便在两阶段事务提交的第二阶段在后台异步执行。启用此功能可以减少事务提交的延迟。

> **注意：**
>
> - 默认值 `ON` 仅适用于新集群。如果您的集群是从早期版本的 TiDB 升级而来，则将使用值 `OFF`。
> - 如果您已启用 TiDB Binlog，则启用此变量无法提高性能。为了提高性能，建议使用 [TiCDC](https://docs.pingcap.com/tidb/stable/ticdc-overview) 代替。
> - 启用此参数仅意味着异步提交成为事务提交的可选模式。实际上，最合适的事务提交模式由 TiDB 决定。

### tidb_enable_auto_analyze <span class="version-mark">New in v6.1.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。