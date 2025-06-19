- 范围：全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`
- 决定 TiDB 是否自动更新表统计信息作为后台操作。
- 此设置以前是 `tidb.toml` 选项 (`performance.run-auto-analyze`)，但从 TiDB v6.1.0 开始更改为系统变量。

### tidb_enable_auto_analyze_priority_queue <span class="version-mark">v8.0.0 新增</span>

- 范围：全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`
- 此变量用于控制是否启用优先级队列来调度自动收集统计信息的任务。启用此变量后，TiDB 会优先收集对收集更有价值的表的统计信息，例如新创建的索引和具有分区更改的分区表。此外，TiDB 会优先处理健康评分较低的表，将其放在队列的前面。

### tidb_enable_auto_increment_in_generated

- 范围：会话 | 全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`OFF`
- 此变量用于确定在创建生成列或表达式索引时是否包含 `AUTO_INCREMENT` 列。

### tidb_enable_batch_dml

> **警告：**
>
> 此变量与已弃用的 batch-dml 功能相关联，可能会导致数据损坏。因此，不建议为 batch-dml 启用此变量。请改用[非事务性 DML](/non-transactional-dml.md)。

- 范围：全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`OFF`
- 此变量控制是否启用已弃用的 batch-dml 功能。启用后，某些语句可能会拆分为多个事务，这是非原子的，应谨慎使用。使用 batch-dml 时，必须确保您操作的数据上没有并发操作。要使其工作，您还必须为 `tidb_batch_dml_size` 指定一个正值，并启用 `tidb_batch_insert` 和 `tidb_batch_delete` 中的至少一个。

### tidb_enable_cascades_planner

> **警告：**
>
> 目前，cascades planner 是一项实验性功能。不建议在生产环境中使用它。

- 范围：会话 | 全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：布尔型
- 默认值：`OFF`
- 此变量用于控制是否启用 cascades planner。

### tidb_enable_check_constraint <span class="version-mark">v7.2.0 新增</span>

- 范围：全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`OFF`
- 此变量用于控制是否启用 [`CHECK` 约束](/constraints.md#check)功能。

### tidb_enable_chunk_rpc <span class="version-mark">v4.0 新增</span>

- 范围：会话
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`
- 此变量用于控制是否在 Coprocessor 中启用 `Chunk` 数据编码格式。

### tidb_enable_clustered_index <span class="version-mark">v5.0 新增</span>

- 范围：会话 | 全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`ON`
- 可选值：`OFF`、`ON`、`INT_ONLY`
- 此变量用于控制是否默认将主键创建为[聚簇索引](/clustered-indexes.md)。“默认”是指语句未显式指定关键字 `CLUSTERED`/`NONCLUSTERED`。支持的值为 `OFF`、`ON` 和 `INT_ONLY`：
    - `OFF` 表示默认将主键创建为非聚簇索引。
    - `ON` 表示默认将主键创建为聚簇索引。
    - `INT_ONLY` 表示该行为由配置项 `alter-primary-key` 控制。如果 `alter-primary-key` 设置为 `true`，则默认将所有主键创建为非聚簇索引。如果设置为 `false`，则仅将由整数列组成的主键创建为聚簇索引。

### tidb_enable_ddl <span class="version-mark">v6.3.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 范围：全局
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 可选值：`OFF`、`ON`
- 此变量控制相应的 TiDB 实例是否可以成为 DDL 所有者。如果当前 TiDB 集群中只有一个 TiDB 实例，则无法阻止其成为 DDL 所有者，这意味着您无法将其设置为 `OFF`。

### tidb_enable_collect_execution_info

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 范围：全局
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`ON`
- 此变量控制是否在慢查询日志中记录每个算子的执行信息，以及是否记录[索引的使用统计信息](/information-schema/information-schema-tidb-index-usage.md)。

### tidb_enable_column_tracking <span class="version-mark">v5.4.0 新增</span>

> **警告：**
>
> 目前，收集 `PREDICATE COLUMNS` 的统计信息是一项实验性功能。不建议在生产环境中使用它。

- 范围：全局
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型
- 默认值：`OFF`
- 此变量控制是否启用 TiDB 收集 `PREDICATE COLUMNS`。启用收集后，如果禁用它，则会清除先前收集的 `PREDICATE COLUMNS` 的信息。有关详细信息，请参见[收集某些列的统计信息](/statistics.md#collect-statistics-on-some-columns)。

### tidb_enable_enhanced_security

- 范围：无
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔型

<CustomContent platform="tidb">

- 默认值：`OFF`
- 此变量指示您连接的 TiDB 服务器是否启用了安全增强模式 (SEM)。要更改其值，您需要修改 TiDB 服务器配置文件中 `enable-sem` 的值并重新启动 TiDB 服务器。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 默认值：`ON`
- 此变量是只读的。对于 TiDB Cloud，默认启用安全增强模式 (SEM)。

</CustomContent>

- SEM 的灵感来自 [Security-Enhanced Linux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux) 等系统的设计。它减少了具有 MySQL `SUPER` 权限的用户的能力，而是需要授予 `RESTRICTED` 细粒度权限作为替代。这些细粒度权限包括：
    - `RESTRICTED_TABLES_ADMIN`：能够将数据写入 `mysql` schema 中的系统表，并查看 `information_schema` 表上的敏感列。
    - `RESTRICTED_STATUS_ADMIN`：能够查看命令 `SHOW STATUS` 中的敏感变量。
    - `RESTRICTED_VARIABLES_ADMIN`：能够查看和设置 `SHOW [GLOBAL] VARIABLES` 和 `SET` 中的敏感变量。