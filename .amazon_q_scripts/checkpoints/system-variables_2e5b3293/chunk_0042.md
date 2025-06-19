- 每次从 PD 获取 TSO 请求时，TiDB 使用的 PD Client 会尽可能多地收集同时收到的 TSO 请求。然后，PD Client 将收集到的请求批量合并为一个 RPC 请求，并将其发送到 PD。这有助于减轻 PD 的压力。
- 将此变量设置为大于 `0` 的值后，TiDB 会在每次批量合并结束前等待此值的最大持续时间。这是为了收集更多的 TSO 请求并提高批量操作的效果。
- 增加此变量值的场景：
    * 由于 TSO 请求的压力过大，PD leader 的 CPU 达到瓶颈，导致 TSO RPC 请求的延迟较高。
    * 集群中的 TiDB 实例不多，但每个 TiDB 实例都处于高并发状态。
- 建议将此变量设置为尽可能小的值。

> **注意：**
>
> 假设 TSO RPC 延迟增加的原因不是 PD leader 的 CPU 使用率瓶颈（例如网络问题）。在这种情况下，增加 `tidb_tso_client_batch_max_wait_time` 的值可能会增加 TiDB 中的执行延迟，并影响集群的 QPS 性能。

### tidb_ttl_delete_rate_limit <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`0`
- 范围：`[0, 9223372036854775807]`
- 此变量用于限制每个 TiDB 节点上 TTL 作业中 `DELETE` 语句的速率。该值表示 TTL 作业中单个节点每秒允许的最大 `DELETE` 语句数。当此变量设置为 `0` 时，不应用任何限制。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_delete_batch_size <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`100`
- 范围：`[1, 10240]`
- 此变量用于设置 TTL 作业中单个 `DELETE` 事务中可以删除的最大行数。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_delete_worker_count <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`4`
- 范围：`[1, 256]`
- 此变量用于设置每个 TiDB 节点上 TTL 作业的最大并发数。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_job_enable <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 类型：Boolean
- 此变量用于控制是否启用 TTL 作业。如果设置为 `OFF`，则所有具有 TTL 属性的表都会自动停止清理过期数据。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_scan_batch_size <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`500`
- 范围：`[1, 10240]`
- 此变量用于设置 TTL 作业中用于扫描过期数据的每个 `SELECT` 语句的 `LIMIT` 值。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_scan_worker_count <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`4`
- 范围：`[1, 256]`
- 此变量用于设置每个 TiDB 节点上 TTL 扫描作业的最大并发数。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_job_schedule_window_start_time <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Time
- 持久化到集群：是
- 默认值：`00:00 +0000`
- 此变量用于控制后台 TTL 作业的调度窗口的开始时间。修改此变量的值时，请注意，较小的窗口可能会导致过期数据清理失败。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_job_schedule_window_end_time <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Time
- 持久化到集群：是
- 默认值：`23:59 +0000`
- 此变量用于控制后台 TTL 作业的调度窗口的结束时间。修改此变量的值时，请注意，较小的窗口可能会导致过期数据清理失败。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_ttl_running_tasks <span class="version-mark">v7.0.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`-1` 和 `[1, 256]`
- 指定整个集群中正在运行的 TTL 任务的最大数量。 `-1` 表示 TTL 任务的数量等于 TiKV 节点的数量。有关更多信息，请参阅 [Time to Live](/time-to-live.md)。

### tidb_txn_assertion_level <span class="version-mark">v6.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`FAST`
- 可能的值：`OFF`、`FAST`、`STRICT`
- 此变量用于控制断言级别。断言是数据和索引之间的一致性检查，用于检查正在写入的键在事务提交过程中是否存在。有关更多信息，请参阅 [解决数据和索引不一致问题](/troubleshoot-data-inconsistency-errors.md)。

    - `OFF`：禁用此检查。
    - `FAST`：启用大多数检查项，几乎不影响性能。
    - `STRICT`：启用所有检查项，当系统工作负载较高时，对悲观事务性能有轻微影响。

- 对于 v6.0.0 或更高版本的新集群，默认值为 `FAST`。对于从低于 v6.0.0 的版本升级的现有集群，默认值为 `OFF`。

### tidb_txn_commit_batch_size <span class="version-mark">v6.2.0 新增</span>