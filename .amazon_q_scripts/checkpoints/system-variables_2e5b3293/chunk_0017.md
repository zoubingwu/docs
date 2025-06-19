- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔型
- 默认值：`ON`
- 决定是否启用 [Prepared Plan Cache](/sql-prepared-plan-cache.md)。启用后，`Prepare` 和 `Execute` 的执行计划会被缓存，以便后续执行跳过优化执行计划的步骤，从而提高性能。
- 此设置之前是 `tidb.toml` 中的一个选项 (`prepared-plan-cache.enabled`)，但从 TiDB v6.1.0 开始更改为系统变量。

### tidb_enable_prepared_plan_cache_memory_monitor <span class="version-mark">v6.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 此变量控制是否统计 Prepared Plan Cache 中缓存的执行计划所消耗的内存。有关详细信息，请参阅 [Prepared Plan Cache 的内存管理](/sql-prepared-plan-cache.md#memory-management-of-prepared-plan-cache)。

### tidb_enable_pseudo_for_outdated_stats <span class="version-mark">v5.3.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔型
- 默认值：`OFF`
- 此变量控制优化器在表统计信息过期时使用该统计信息的行为。

<CustomContent platform="tidb">

- 优化器通过以下方式确定表的统计信息是否过期：自上次对表执行 `ANALYZE` 以获取统计信息以来，如果 80% 的表行被修改（修改的行数除以总行数），则优化器确定此表的统计信息已过期。您可以使用 [`pseudo-estimate-ratio`](/tidb-configuration-file.md#pseudo-estimate-ratio) 配置更改此比率。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 优化器通过以下方式确定表的统计信息是否过期：自上次对表执行 `ANALYZE` 以获取统计信息以来，如果 80% 的表行被修改（修改的行数除以总行数），则优化器确定此表的统计信息已过期。

</CustomContent>

- 默认情况下（变量值为 `OFF`），当表的统计信息过期时，优化器仍会继续使用该表的统计信息。如果将变量值设置为 `ON`，则优化器会确定该表的统计信息不再可靠，除非总行数。然后，优化器使用伪统计信息。
- 如果表上的数据经常被修改而没有及时对该表执行 `ANALYZE`，为了保持执行计划的稳定，建议将变量值设置为 `OFF`。

### tidb_enable_rate_limit_action

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`OFF`
- 此变量控制是否为读取数据的算子启用动态内存控制功能。默认情况下，此算子启用 [`tidb_distsql_scan_concurrency`](/system-variables.md#tidb_distsql_scan_concurrency) 允许的最大线程数来读取数据。当单个 SQL 语句的内存使用量每次超过 [`tidb_mem_quota_query`](/system-variables.md#tidb_mem_quota_query) 时，读取数据的算子会停止一个线程。

<CustomContent platform="tidb">

- 当读取数据的算子只剩下一个线程，并且单个 SQL 语句的内存使用量持续超过 [`tidb_mem_quota_query`](/system-variables.md#tidb_mem_quota_query) 时，此 SQL 语句会触发其他内存控制行为，例如 [将数据溢出到磁盘](/system-variables.md#tidb_enable_tmp_storage_on_oom)。
- 当 SQL 语句仅读取数据时，此变量可以有效地控制内存使用量。如果需要计算操作（例如连接或聚合操作），则内存使用量可能不受 `tidb_mem_quota_query` 的控制，这会增加 OOM 的风险。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 当读取数据的算子只剩下一个线程，并且单个 SQL 语句的内存使用量继续超过 [`tidb_mem_quota_query`](/system-variables.md#tidb_mem_quota_query) 时，此 SQL 语句会触发其他内存控制行为，例如将数据溢出到磁盘。

</CustomContent>

### tidb_enable_resource_control <span class="version-mark">v6.6.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 类型：布尔型
- 此变量是 [资源控制功能](/tidb-resource-control.md) 的开关。当此变量设置为 `ON` 时，TiDB 集群可以基于资源组隔离应用程序资源。

### tidb_enable_reuse_chunk <span class="version-mark">v6.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 可选值：`OFF`，`ON`
- 此变量控制 TiDB 是否启用 chunk 对象缓存。如果值为 `ON`，TiDB 倾向于使用缓存的 chunk 对象，只有当请求的对象不在缓存中时才从系统请求。如果值为 `OFF`，TiDB 直接从系统请求 chunk 对象。

### tidb_enable_slow_log

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`
- 此变量用于控制是否启用慢查询日志功能。

### tidb_enable_tmp_storage_on_oom

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 可选值：`OFF`，`ON`
- 控制当单个 SQL 语句超过系统变量 [`tidb_mem_quota_query`](/system-variables.md#tidb_mem_quota_query) 指定的内存配额时，是否为某些算子启用临时存储。
- 在 v6.3.0 之前，您可以使用 TiDB 配置项 `oom-use-tmp-storage` 启用或禁用此功能。将集群升级到 v6.3.0 或更高版本后，TiDB 集群将使用 `oom-use-tmp-storage` 的值自动初始化此变量。之后，更改 `oom-use-tmp-storage` 的值将**不再**生效。

### tidb_enable_stmt_summary <span class="version-mark">v3.0.4 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`
- 此变量用于控制是否启用语句摘要功能。如果启用，SQL 执行信息（如时间消耗）将被记录到 `information_schema.STATEMENTS_SUMMARY` 系统表中，以识别和排除 SQL 性能问题。

### tidb_enable_strict_double_type_check <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`