从 v6.6.0 版本开始，TiDB 支持 [资源控制](/tidb-resource-control.md)。你可以使用此功能在不同的资源组中以不同的优先级执行 SQL 语句。通过为这些资源组配置适当的配额和优先级，你可以更好地控制具有不同优先级的 SQL 语句的调度。启用资源控制后，语句优先级将不再生效。建议你使用 [资源控制](/tidb-resource-control.md) 来管理不同 SQL 语句的资源使用情况。

### tidb_gc_concurrency <span class="version-mark">v5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`-1`
- 范围：`[1, 256]`
- 单位：线程
- 指定 GC 的 [Resolve Locks](/garbage-collection-overview.md#resolve-locks) 步骤中的线程数。值为 `-1` 表示 TiDB 将自动决定要使用的垃圾回收线程数。

### tidb_gc_enable <span class="version-mark">v5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 启用 TiKV 的垃圾回收。禁用垃圾回收会降低系统性能，因为旧版本的行将不再被清除。

### tidb_gc_life_time <span class="version-mark">v5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Duration
- 默认值：`10m0s`
- 范围：对于 TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `[10m0s, 8760h0m0s]`，对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `[10m0s, 168h0m0s]`
- 每次 GC 保留数据的时间限制，格式为 Go Duration。发生 GC 时，当前时间减去此值即为安全点。

> **注意：**
>
> - 在频繁更新的场景中，`tidb_gc_life_time` 的较大值（几天甚至几个月）可能会导致潜在问题，例如：
>     - 更大的存储使用量
>     - 大量的历史数据可能会在一定程度上影响性能，特别是对于范围查询，例如 `select count(*) from t`
> - 如果有任何事务的运行时间超过 `tidb_gc_life_time`，在 GC 期间，将保留自 `start_ts` 以来的数据，以使该事务继续执行。例如，如果 `tidb_gc_life_time` 配置为 10 分钟，在所有正在执行的事务中，最早开始的事务已经运行了 15 分钟，GC 将保留最近 15 分钟的数据。

### tidb_gc_max_wait_time <span class="version-mark">v6.1.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`86400`
- 范围：`[600, 31536000]`
- 单位：秒
- 此变量用于设置活动事务阻塞 GC 安全点的最大时间。在每次 GC 时，默认情况下，安全点不会超过正在进行的事务的开始时间。如果活动事务的运行时长不超过此变量值，则 GC 安全点将被阻塞，直到运行时长超过此值。

### tidb_gc_run_interval <span class="version-mark">v5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Duration
- 默认值：`10m0s`
- 范围：`[10m0s, 8760h0m0s]`
- 指定 GC 间隔，格式为 Go Duration，例如 `"1h30m"` 和 `"15m"`

### tidb_gc_scan_lock_mode <span class="version-mark">v5.0 新增</span>

> **警告：**
>
> 目前，Green GC 是一项实验性功能。不建议在生产环境中使用它。

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`LEGACY`
- 可选值：`PHYSICAL`，`LEGACY`
    - `LEGACY`：使用旧的扫描方式，即禁用 Green GC。
    - `PHYSICAL`：使用物理扫描方法，即启用 Green GC。

<CustomContent platform="tidb">

- 此变量指定 GC 的 Resolve Locks 步骤中扫描锁的方式。当变量值设置为 `LEGACY` 时，TiDB 按 Region 扫描锁。当使用值 `PHYSICAL` 时，它使每个 TiKV 节点能够绕过 Raft 层并直接扫描数据，这可以有效地缓解启用 [Hibernate Region](/tikv-configuration-file.md#hibernate-regions) 功能时 GC 唤醒所有 Region 的影响，从而提高 Resolve Locks 步骤的执行速度。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量指定 GC 的 Resolve Locks 步骤中扫描锁的方式。当变量值设置为 `LEGACY` 时，TiDB 按 Region 扫描锁。当使用值 `PHYSICAL` 时，它使每个 TiKV 节点能够绕过 Raft 层并直接扫描数据，这可以有效地缓解 GC 唤醒所有 Region 的影响，从而提高 Resolve Locks 步骤的执行速度。

</CustomContent>

### tidb_general_log

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于你当前连接的 TiDB 实例。
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`

<CustomContent platform="tidb-cloud">

- 此变量用于设置是否在日志中记录所有 SQL 语句。默认情况下，此功能已禁用。如果需要在定位问题时跟踪所有 SQL 语句，请启用此功能。

</CustomContent>

<CustomContent platform="tidb">

- 此变量用于设置是否将所有 SQL 语句记录在 [日志](/tidb-configuration-file.md#logfile) 中。默认情况下，此功能已禁用。如果维护人员需要在定位问题时跟踪所有 SQL 语句，他们可以启用此功能。

- 如果指定了 [`log.general-log-file`](/tidb-configuration-file.md#general-log-file-new-in-v800) 配置项，则通用日志将单独写入指定的文件。

- [`log.format`](/tidb-configuration-file.md#format) 配置项使你能够配置日志消息格式，无论通用日志是位于单独的文件中还是与其他日志组合在一起。

- [`tidb_redact_log`](#tidb_redact_log) 变量使你能够编辑通用日志中记录的 SQL 语句。

- 只有成功执行的语句才会记录在通用日志中。失败的语句不会记录在通用日志中，而是记录在 TiDB 日志中，并显示 `command dispatched failed` 消息。
</CustomContent>