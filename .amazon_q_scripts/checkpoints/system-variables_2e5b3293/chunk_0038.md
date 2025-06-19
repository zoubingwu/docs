- 只有内存使用量超过 [`tidb_server_memory_limit_sess_min_size`](/system-variables.md#tidb_server_memory_limit_sess_min_size-new-in-v640) 限制的 SQL 语句才会被优先选择取消。
- 目前，TiDB 每次只会取消一个 SQL 语句。在 TiDB 完全取消一个 SQL 语句并回收资源后，如果内存使用量仍然大于此变量设置的限制，TiDB 才会开始下一个取消操作。

### tidb_server_memory_limit_gc_trigger <span class="version-mark">New in v6.4.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`70%`
- 范围：`[50%, 99%]`
- TiDB 尝试触发 GC 的阈值。当 TiDB 的内存使用量达到 `tidb_server_memory_limit` \* `tidb_server_memory_limit_gc_trigger` 的值时，TiDB 将主动触发 Golang GC 操作。一分钟内只会触发一次 GC 操作。

### tidb_server_memory_limit_sess_min_size <span class="version-mark">New in v6.4.0</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`134217728` (即 128 MiB)
- 范围：`[128, 9223372036854775807]`，单位为字节。也支持带有单位 "KiB|MiB|GiB|TiB" 的内存格式。
- 启用内存限制后，TiDB 将终止当前实例上内存使用量最高的 SQL 语句。此变量指定要终止的 SQL 语句的最小内存使用量。如果超过限制的 TiDB 实例的内存使用量是由太多内存使用量低的会话引起的，您可以适当降低此变量的值，以允许取消更多会话。

### tidb_service_scope <span class="version-mark">New in v7.4.0</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：String
- 默认值：""
- 可选值：长度不超过 64 个字符的字符串。有效字符包括数字 `0-9`、字母 `a-zA-Z`、下划线 `_` 和连字符 `-`。
- 此变量是一个实例级别的系统变量。您可以使用它来控制 [TiDB 分布式执行框架 (DXF)](/tidb-distributed-execution-framework.md) 下每个 TiDB 节点的 Service Scope。DXF 根据此变量的值确定可以将哪些 TiDB 节点调度来执行分布式任务。有关具体规则，请参见[任务调度](/tidb-distributed-execution-framework.md#task-scheduling)。

### tidb_session_alias <span class="version-mark">New in v7.4.0</span>

- 作用域：SESSION
- 是否持久化到集群：否
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：""
- 您可以使用此变量自定义与当前会话相关的日志中 `session_alias` 列的值，这有助于在问题排查中识别会话。此设置会影响语句执行涉及的多个节点（包括 TiKV）的日志。此变量的最大长度限制为 64 个字符，任何超过长度的字符都将被自动截断。值末尾的空格也会被自动删除。

### tidb_session_plan_cache_size <span class="version-mark">New in v7.1.0</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`100`
- 范围：`[1, 100000]`
- 此变量控制可以缓存的最大计划数。[Prepared plan cache](/sql-prepared-plan-cache.md) 和 [non-prepared plan cache](/sql-non-prepared-plan-cache.md) 共享同一个缓存。
- 当您从早期版本升级到 v7.1.0 或更高版本时，此变量的值与 [`tidb_prepared_plan_cache_size`](#tidb_prepared_plan_cache_size-new-in-v610) 保持相同。

### tidb_shard_allocate_step <span class="version-mark">New in v5.0</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`9223372036854775807`
- 范围：`[1, 9223372036854775807]`
- 此变量控制为 [`AUTO_RANDOM`](/auto-random.md) 或 [`SHARD_ROW_ID_BITS`](/shard-row-id-bits.md) 属性分配的连续 ID 的最大数量。通常，`AUTO_RANDOM` ID 或 `SHARD_ROW_ID_BITS` 注释的行 ID 在一个事务中是递增且连续的。您可以使用此变量来解决大型事务场景中的热点问题。

### tidb_simplified_metrics

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 启用此变量后，TiDB 不会收集或记录 Grafana 面板中未使用的指标。

### tidb_skip_ascii_check <span class="version-mark">New in v5.0</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于设置是否跳过 ASCII 验证。
- 验证 ASCII 字符会影响性能。当您确定输入字符是有效的 ASCII 字符时，可以将变量值设置为 `ON`。

### tidb_skip_isolation_level_check

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 启用此开关后，如果将 TiDB 不支持的隔离级别分配给 `tx_isolation`，则不会报告错误。这有助于提高与设置（但不依赖于）不同隔离级别的应用程序的兼容性。

```sql
tidb> set tx_isolation='serializable';
ERROR 8048 (HY000): The isolation level 'serializable' is not supported. Set tidb_skip_isolation_level_check=1 to skip this error
tidb> set tidb_skip_isolation_level_check=1;
Query OK, 0 rows affected (0.00 sec)

tidb> set tx_isolation='serializable';
Query OK, 0 rows affected, 1 warning (0.00 sec)
```

### tidb_skip_missing_partition_stats <span class="version-mark">New in v7.3.0</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 在[动态分区裁剪模式](/partitioned-table.md#dynamic-pruning-mode)下访问分区表时，TiDB 会聚合每个分区的统计信息以生成 GlobalStats。此变量控制在缺少分区统计信息时 GlobalStats 的生成。

    - 如果此变量为 `ON`，TiDB 在生成 GlobalStats 时会跳过缺少的分区统计信息，因此 GlobalStats 的生成不受影响。
    - 如果此变量为 `OFF`，TiDB 在检测到任何缺少的分区统计信息时会停止生成 GlobalStats。

### tidb_skip_utf8_check

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于设置是否跳过 UTF-8 验证。