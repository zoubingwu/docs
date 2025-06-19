- 启用只读模式后，所有用户（包括具有 `SUPER` 权限的用户）都无法执行可能写入数据的 SQL 语句，除非用户被明确授予 `RESTRICTED_REPLICA_WRITER_ADMIN` 权限。

### tidb_request_source_type <span class="version-mark">v7.4.0 新增</span>

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：String
- 默认值：`""`
- 可选值：`"ddl"`, `"stats"`, `"br"`, `"lightning"`, `"background"`
- 此变量用于显式指定当前会话的任务类型，该类型由 [资源控制](/tidb-resource-control.md) 识别和控制。例如：`SET @@tidb_request_source_type = "background"`。

### tidb_retry_limit

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`10`
- 范围：`[-1, 9223372036854775807]`
- 此变量用于设置乐观事务的最大重试次数。当事务遇到可重试错误（例如事务冲突、事务提交非常慢或表结构更改）时，将根据此变量重新执行该事务。请注意，将 `tidb_retry_limit` 设置为 `0` 会禁用自动重试。此变量仅适用于乐观事务，不适用于悲观事务。

### tidb_row_format_version

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`2`
- 范围：`[1, 2]`
- 控制表中新保存数据的格式版本。在 TiDB v4.0 中，默认使用 [新的存储行格式](https://github.com/pingcap/tidb/blob/release-8.1/docs/design/2018-07-19-row-format.md) 版本 `2` 来保存新数据。
- 如果您从低于 v4.0.0 的 TiDB 版本升级到 v4.0.0 或更高版本，则格式版本不会更改，TiDB 将继续使用版本 `1` 的旧格式将数据写入表，这意味着**只有新创建的集群默认使用新的数据格式**。
- 请注意，修改此变量不会影响已保存的旧数据，而是仅将相应的版本格式应用于修改此变量后新写入的数据。

### tidb_runtime_filter_mode <span class="version-mark">v7.2.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Enumeration
- 默认值：`OFF`
- 可选值：`OFF`, `LOCAL`
- 控制 Runtime Filter 的模式，即 **Filter Sender operator** 和 **Filter Receiver operator** 之间的关系。有两种模式：`OFF` 和 `LOCAL`。`OFF` 表示禁用 Runtime Filter。`LOCAL` 表示在本地模式下启用 Runtime Filter。有关更多信息，请参见 [Runtime Filter 模式](/runtime-filter.md#runtime-filter-mode)。

### tidb_runtime_filter_type <span class="version-mark">v7.2.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Enumeration
- 默认值：`IN`
- 可选值：`IN`
- 控制生成的 Filter operator 使用的谓词类型。目前，仅支持一种类型：`IN`。有关更多信息，请参见 [Runtime Filter 类型](/runtime-filter.md#runtime-filter-type)。

### tidb_scatter_region

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 默认情况下，在 TiDB 中创建新表时，会拆分 Region。启用此变量后，新拆分的 Region 会在执行 `CREATE TABLE` 语句期间立即分散。这适用于在批量创建表后需要批量写入数据的场景，因为新拆分的 Region 可以预先分散在 TiKV 中，而不必等待 PD 调度。为了确保批量写入数据的持续稳定性，只有在 Region 成功分散后，`CREATE TABLE` 语句才会返回成功。这使得语句的执行时间比禁用此变量时长数倍。
- 请注意，如果在创建表时已设置 `SHARD_ROW_ID_BITS` 和 `PRE_SPLIT_REGIONS`，则在创建表后会均匀拆分指定数量的 Region。

### tidb_schema_cache_size <span class="version-mark">v8.0.0 新增</span>

> **警告：**
>
> 此变量控制的功能在当前 TiDB 版本中尚未生效。请勿更改默认值。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 9223372036854775807]`
- 此变量控制 TiDB 中 schema 缓存的大小。单位是字节。默认值为 `0`，表示未启用缓存限制功能。启用此功能后，TiDB 使用您设置的值作为最大可用内存限制，并使用最近最少使用 (LRU) 算法来缓存所需的表，从而有效减少 schema 信息占用的内存。

### tidb_schema_version_cache_limit <span class="version-mark">v7.4.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`16`
- 范围：`[2, 255]`
- 此变量限制了 TiDB 实例中可以缓存的历史 schema 版本的数量。默认值为 `16`，表示 TiDB 默认缓存 16 个历史 schema 版本。
- 通常，您不需要修改此变量。当使用 [Stale Read](/stale-read.md) 功能并且频繁执行 DDL 操作时，会导致 schema 版本非常频繁地更改。因此，当 Stale Read 尝试从快照中获取 schema 信息时，由于 schema 缓存未命中，可能需要花费大量时间来重建信息。在这种情况下，您可以增加 `tidb_schema_version_cache_limit` 的值（例如，`32`）以避免 schema 缓存未命中的问题。
- 修改此变量会导致 TiDB 的内存使用量略有增加。监控 TiDB 的内存使用情况以避免 OOM 问题。

### tidb_server_memory_limit <span class="version-mark">v6.4.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`80%`
- 范围：
    - 您可以设置百分比格式的值，这意味着内存使用量相对于总内存的百分比。取值范围为 `[1%, 99%]`。
    - 您也可以设置内存大小的值。取值范围为 `0` 和 `[536870912, 9223372036854775807]`（以字节为单位）。支持带有单位 "KiB|MiB|GiB|TiB" 的内存格式。`0` 表示没有内存限制。
    - 如果此变量设置为小于 512 MiB 但不为 `0` 的内存大小，则 TiDB 使用 512 MiB 作为实际大小。
- 此变量指定 TiDB 实例的内存限制。当 TiDB 的内存使用量达到限制时，TiDB 会取消当前运行的内存使用量最高的 SQL 语句。成功取消 SQL 语句后，TiDB 会尝试调用 Golang GC 以立即回收内存，从而尽快缓解内存压力。