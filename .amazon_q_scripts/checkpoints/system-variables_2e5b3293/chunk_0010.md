- 此变量控制是否启用 `ADD INDEX` 和 `CREATE INDEX` 的加速功能，以提高创建索引时回填数据的速度。将此变量值设置为 `ON` 可以提高大数据量表上创建索引的性能。
- 从 v7.1.0 版本开始，索引加速操作支持检查点。即使 TiDB owner 节点由于故障而重启或更改，TiDB 仍然可以从定期自动更新的检查点恢复进度。
- 要验证已完成的 `ADD INDEX` 操作是否已加速，您可以执行 [`ADMIN SHOW DDL JOBS`](/sql-statements/sql-statement-admin-show-ddl.md#admin-show-ddl-jobs) 语句，查看 `JOB_TYPE` 列中是否显示 `ingest`。

<CustomContent platform="tidb">

> **注意：**
>
> * 索引加速需要一个可写的且具有足够可用空间的 [`temp-dir`](/tidb-configuration-file.md#temp-dir-new-in-v630)。如果 `temp-dir` 不可用，TiDB 将回退到非加速索引构建。建议将 `temp-dir` 放在 SSD 磁盘上。
>
> * 在将 TiDB 升级到 v6.5.0 或更高版本之前，建议您检查 TiDB 的 [`temp-dir`](/tidb-configuration-file.md#temp-dir-new-in-v630) 路径是否已正确挂载到 SSD 磁盘。确保运行 TiDB 的操作系统用户具有此目录的读写权限。否则，DDL 操作可能会遇到不可预测的问题。此路径是 TiDB 配置项，在 TiDB 重启后生效。因此，在升级前设置此配置项可以避免再次重启。

</CustomContent>

<CustomContent platform="tidb-cloud">

> **警告：**
>
> 目前，此功能与[在单个 `ALTER TABLE` 语句中更改多个列或索引](/sql-statements/sql-statement-alter-table.md)不完全兼容。在使用索引加速添加唯一索引时，需要避免在同一语句中更改其他列或索引。

</CustomContent>

### tidb_enable_dist_task <span class="version-mark">v7.1.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否支持 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 此变量用于控制是否启用 [TiDB 分布式执行框架 (DXF)](/tidb-distributed-execution-framework.md)。启用该框架后，DDL 和导入等 DXF 任务将由集群中的多个 TiDB 节点分布式执行和完成。
- 从 TiDB v7.1.0 开始，DXF 支持分布式执行分区表的 [`ADD INDEX`](/sql-statements/sql-statement-add-index.md) 语句。
- 从 TiDB v7.2.0 开始，DXF 支持分布式执行导入作业的 [`IMPORT INTO`](/sql-statements/sql-statement-import-into.md) 语句。
- 从 TiDB v8.1.0 开始，默认启用此变量。如果要将启用了 DXF 的集群升级到 v8.1.0 或更高版本，请在升级前禁用 DXF（通过将 `tidb_enable_dist_task` 设置为 `OFF`），以避免升级期间的 `ADD INDEX` 操作导致数据索引不一致。升级后，您可以手动启用 DXF。
- 此变量已从 `tidb_ddl_distribute_reorg` 重命名。

### tidb_cloud_storage_uri <span class="version-mark">v7.4.0 新增</span>

> **注意：**
>
> 目前，[全局排序](/tidb-global-sort.md)过程会消耗 TiDB 节点的大量计算和内存资源。在用户业务应用程序正在运行的情况下在线添加索引等场景中，建议向集群添加新的 TiDB 节点，为这些节点配置 [`tidb_service_scope`](/system-variables.md#tidb_service_scope-new-in-v740) 变量，并连接到这些节点以创建任务。这样，分布式框架会将任务调度到这些节点，从而将工作负载与其他 TiDB 节点隔离，以减少执行 `ADD INDEX` 和 `IMPORT INTO` 等后端任务对用户业务应用程序的影响。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否支持 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`""`
- 此变量用于指定 Amazon S3 云存储 URI 以启用[全局排序](/tidb-global-sort.md)。启用 [TiDB 分布式执行框架 (DXF)](/tidb-distributed-execution-framework.md) 后，您可以通过配置 URI 并将其指向具有访问存储所需权限的适当云存储路径来使用全局排序功能。有关更多详细信息，请参阅 [Amazon S3 URI 格式](/external-storage-uri.md#amazon-s3-uri-format)。
- 以下语句可以使用全局排序功能。
    - [`ADD INDEX`](/sql-statements/sql-statement-add-index.md) 语句。
    - 导入作业的 [`IMPORT INTO`](/sql-statements/sql-statement-import-into.md) 语句。

### tidb_ddl_error_count_limit

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否支持 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`512`
- 范围：`[0, 9223372036854775807]`
- 此变量用于设置 DDL 操作失败时的重试次数。当重试次数超过参数值时，错误的 DDL 操作将被取消。

### tidb_ddl_flashback_concurrency <span class="version-mark">v6.3.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否支持 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`64`
- 范围：`[1, 256]`
- 此变量控制 [`FLASHBACK CLUSTER`](/sql-statements/sql-statement-flashback-cluster.md) 的并发性。

### tidb_ddl_reorg_batch_size

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否支持 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`256`
- 范围：`[32, 10240]`
- 单位：行
- 此变量用于设置 DDL 操作的 `re-organize` 阶段的批量大小。例如，当 TiDB 执行 `ADD INDEX` 操作时，索引数据需要由 `tidb_ddl_reorg_worker_cnt` （数量）个并发 worker 回填。每个 worker 批量回填索引数据。
    - 如果 `tidb_ddl_enable_fast_reorg` 设置为 `OFF`，则 `ADD INDEX` 作为事务执行。如果在 `ADD INDEX` 执行期间目标列中存在许多更新操作（例如 `UPDATE` 和 `REPLACE`），则较大的批量大小表示事务冲突的可能性更大。在这种情况下，建议您将批量大小设置为较小的值。最小值是 32。
    - 如果不存在事务冲突，或者如果 `tidb_ddl_enable_fast_reorg` 设置为 `ON`，则可以将批量大小设置为较大的值。这使得数据回填更快，但也增加了 TiKV 的写入压力。对于合适的批量大小，您还需要参考 `tidb_ddl_reorg_worker_cnt` 的值。有关参考，请参阅 [在线工作负载和 `ADD INDEX` 操作的交互测试](https://docs.pingcap.com/tidb/dev/online-workloads-and-add-index-operations)。

### tidb_ddl_reorg_priority

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION
- 是否支持 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`PRIORITY_LOW`