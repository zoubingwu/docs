- 该变量用于控制是否启用已弃用的批量提交功能。启用此变量后，事务可能会被拆分为多个事务，通过对一些语句进行分组并以非原子方式提交，不建议这样做。

### tidb_batch_delete

> **警告：**
>
> 此变量与已弃用的批量 DML 功能相关联，可能会导致数据损坏。因此，不建议为批量 DML 启用此变量。请改用[非事务性 DML](/non-transactional-dml.md)。

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 该变量用于控制是否启用批量删除功能，该功能是已弃用的批量 DML 功能的一部分。启用此变量后，`DELETE` 语句可能会被拆分为多个事务并以非原子方式提交。要使其工作，还需要启用 `tidb_enable_batch_dml` 并为 `tidb_dml_batch_size` 设置一个正值，不建议这样做。

### tidb_batch_insert

> **警告：**
>
> 此变量与已弃用的批量 DML 功能相关联，可能会导致数据损坏。因此，不建议为批量 DML 启用此变量。请改用[非事务性 DML](/non-transactional-dml.md)。

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 该变量用于控制是否启用批量插入功能，该功能是已弃用的批量 DML 功能的一部分。启用此变量后，`INSERT` 语句可能会被拆分为多个事务并以非原子方式提交。要使其工作，还需要启用 `tidb_enable_batch_dml` 并为 `tidb_dml_batch_size` 设置一个正值，不建议这样做。

### tidb_batch_pending_tiflash_count <span class="version-mark">v6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`4000`
- 范围：`[0, 4294967295]`
- 指定使用 `ALTER DATABASE SET TIFLASH REPLICA` 添加 TiFlash 副本时允许的最大不可用表数量。如果不可用表的数量超过此限制，则操作将被停止，或者为剩余表设置 TiFlash 副本的速度将非常慢。

### tidb_broadcast_join_threshold_count <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`10240`
- 范围：`[0, 9223372036854775807]`
- 单位：行
- 如果 join 操作的对象属于子查询，优化器无法估计子查询结果集的大小。在这种情况下，大小由结果集中的行数决定。如果子查询中估计的行数小于此变量的值，则使用 Broadcast Hash Join 算法。否则，使用 Shuffled Hash Join 算法。
- 在启用 [`tidb_prefer_broadcast_join_by_exchange_data_size`](/system-variables.md#tidb_prefer_broadcast_join_by_exchange_data_size-new-in-v710) 后，此变量将不起作用。

### tidb_broadcast_join_threshold_size <span class="version-mark">v5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`104857600` (100 MiB)
- 范围：`[0, 9223372036854775807]`
- 单位：字节
- 如果表大小小于该变量的值，则使用 Broadcast Hash Join 算法。否则，使用 Shuffled Hash Join 算法。
- 在启用 [`tidb_prefer_broadcast_join_by_exchange_data_size`](/system-variables.md#tidb_prefer_broadcast_join_by_exchange_data_size-new-in-v710) 后，此变量将不起作用。

### tidb_build_stats_concurrency

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`2`。对于 v7.4.0 及更早版本，默认值为 `4`。
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置执行 `ANALYZE` 语句的并发性。
- 当变量设置为较大的值时，会影响其他查询的执行性能。

### tidb_build_sampling_stats_concurrency <span class="version-mark">v7.5.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 单位：线程
- 默认值：`2`
- 范围：`[1, 256]`
- 此变量用于设置 `ANALYZE` 过程中的采样并发性。
- 当变量设置为较大的值时，会影响其他查询的执行性能。

### tidb_capture_plan_baselines <span class="version-mark">v4.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于控制是否启用[基线捕获](/sql-plan-management.md#baseline-capturing)功能。此功能依赖于语句摘要，因此在使用基线捕获之前需要启用语句摘要。
- 启用此功能后，会定期遍历语句摘要中的历史 SQL 语句，并自动为至少出现两次的 SQL 语句创建绑定。

### tidb_cdc_write_source <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION
- 是否持久化到集群：否
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 15]`
- 当此变量设置为 0 以外的值时，在此会话中写入的数据被认为是 TiCDC 写入的。此变量只能由 TiCDC 修改。在任何情况下都不要手动修改此变量。

### tidb_check_mb4_value_in_utf8

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量用于强制 `utf8` 字符集仅存储来自 [基本多文种平面 (BMP)](https://en.wikipedia.org/wiki/Plane_(Unicode)#Basic_Multilingual_Plane) 的值。要存储 BMP 之外的字符，建议使用 `utf8mb4` 字符集。
- 当您从早期版本的 TiDB 升级集群时，可能需要禁用此选项，因为早期版本的 TiDB 中 `utf8` 检查更为宽松。有关详细信息，请参见[升级后常见问题解答](https://docs.pingcap.com/tidb/stable/upgrade-faq)。

### tidb_checksum_table_concurrency

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`4`
- 范围：`[1, 256]`
- 单位：线程
- 此变量用于设置执行 [`ADMIN CHECKSUM TABLE`](/sql-statements/sql-statement-admin-checksum-table.md) 语句的扫描索引并发性。
- 当变量设置为较大的值时，会影响其他查询的执行性能。

### tidb_committer_concurrency <span class="version-mark">v6.1.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`128`
- 范围：`[1, 10000]`