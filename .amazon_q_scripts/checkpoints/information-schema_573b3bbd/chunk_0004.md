## 属于 TiDB 扩展的表

<CustomContent platform="tidb">

> **注意：**
>
> 以下某些表仅在 TiDB Self-Managed 上受支持，在 TiDB Cloud 上不受支持。要获取 TiDB Cloud 上不支持的表的完整列表，请参阅[系统表](https://docs.pingcap.com/tidbcloud/limited-sql-features#system-tables)。

| 表名                                                                              | 描述 |
|-----------------------------------------------------------------------------------------|-------------|
| [`ANALYZE_STATUS`](/information-schema/information-schema-analyze-status.md)            | 提供有关收集统计信息的任务的信息。 |
| [`CLIENT_ERRORS_SUMMARY_BY_HOST`](/information-schema/client-errors-summary-by-host.md)  | 提供客户端请求生成并返回给客户端的错误和警告的摘要。 |
| [`CLIENT_ERRORS_SUMMARY_BY_USER`](/information-schema/client-errors-summary-by-user.md)  | 提供客户端生成的错误和警告的摘要。 |
| [`CLIENT_ERRORS_SUMMARY_GLOBAL`](/information-schema/client-errors-summary-global.md)   | 提供客户端生成的错误和警告的摘要。 |
| [`CLUSTER_CONFIG`](/information-schema/information-schema-cluster-config.md)            | 提供有关整个 TiDB 集群的配置设置的详细信息。此表不适用于 TiDB Cloud。 |
| `CLUSTER_DEADLOCKS` | 提供 `DEADLOCKS` 表的集群级别视图。 |
| [`CLUSTER_HARDWARE`](/information-schema/information-schema-cluster-hardware.md)            | 提供有关在每个 TiDB 组件上发现的底层物理硬件的详细信息。此表不适用于 TiDB Cloud。 |
| [`CLUSTER_INFO`](/information-schema/information-schema-cluster-info.md)                | 提供有关当前集群拓扑的详细信息。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| [`CLUSTER_LOAD`](/information-schema/information-schema-cluster-load.md)                | 提供集群中 TiDB 服务器的当前负载信息。此表不适用于 TiDB Cloud。 |
| [`CLUSTER_LOG`](/information-schema/information-schema-cluster-log.md)                  | 提供整个 TiDB 集群的日志。此表不适用于 TiDB Cloud。 |
| `CLUSTER_MEMORY_USAGE`                                                                  | 提供 `MEMORY_USAGE` 表的集群级别视图。 |
| `CLUSTER_MEMORY_USAGE_OPS_HISTORY`                                                      | 提供 `MEMORY_USAGE_OPS_HISTORY` 表的集群级别视图。 |
| `CLUSTER_PROCESSLIST`                                                                   | 提供 `PROCESSLIST` 表的集群级别视图。 |
| `CLUSTER_SLOW_QUERY`                                                                    | 提供 `SLOW_QUERY` 表的集群级别视图。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| `CLUSTER_STATEMENTS_SUMMARY`                                                            | 提供 `STATEMENTS_SUMMARY` 表的集群级别视图。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| `CLUSTER_STATEMENTS_SUMMARY_HISTORY`                                                    | 提供 `STATEMENTS_SUMMARY_HISTORY` 表的集群级别视图。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| `CLUSTER_TIDB_INDEX_USAGE` | 提供 `TIDB_INDEX_USAGE` 表的集群级别视图。 |
| `CLUSTER_TIDB_TRX` | 提供 `TIDB_TRX` 表的集群级别视图。 |
| [`CLUSTER_SYSTEMINFO`](/information-schema/information-schema-cluster-systeminfo.md)    | 提供有关集群中服务器的内核参数配置的详细信息。此表不适用于 TiDB Cloud。 |
| [`DATA_LOCK_WAITS`](/information-schema/information-schema-data-lock-waits.md) | 提供 TiKV 服务器上的锁等待信息。 |
| [`DDL_JOBS`](/information-schema/information-schema-ddl-jobs.md)                        | 提供与 `ADMIN SHOW DDL JOBS` 类似的输出 |
| [`DEADLOCKS`](/information-schema/information-schema-deadlocks.md) | 提供最近发生的几个死锁错误的信息。 |
| [`INSPECTION_RESULT`](/information-schema/information-schema-inspection-result.md)      | 触发内部诊断检查。此表不适用于 TiDB Cloud。 |
| [`INSPECTION_RULES`](/information-schema/information-schema-inspection-rules.md)        | 执行的内部诊断检查的列表。此表不适用于 TiDB Cloud。 |
| [`INSPECTION_SUMMARY`](/information-schema/information-schema-inspection-summary.md)    | 重要监控指标的汇总报告。此表不适用于 TiDB Cloud。 |
| [`MEMORY_USAGE`](/information-schema/information-schema-memory-usage.md)                |  当前 TiDB 实例的内存使用情况。 |
| [`MEMORY_USAGE_OPS_HISTORY`](/information-schema/information-schema-memory-usage-ops-history.md)    | 当前 TiDB 实例的内存相关操作的历史记录和执行依据。 |
| [`METRICS_SUMMARY`](/information-schema/information-schema-metrics-summary.md)          | 从 Prometheus 提取的指标的摘要。此表不适用于 TiDB Cloud。 |
| `METRICS_SUMMARY_BY_LABEL`                                                              | 请参阅 `METRICS_SUMMARY` 表。此表不适用于 TiDB Cloud。 |
| [`METRICS_TABLES`](/information-schema/information-schema-metrics-tables.md)            | 提供 `METRICS_SCHEMA` 中表的 PromQL 定义。此表不适用于 TiDB Cloud。 |
| [`PLACEMENT_POLICIES`](/information-schema/information-schema-placement-policies.md)    | 提供有关所有放置策略的信息。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| [`SEQUENCES`](/information-schema/information-schema-sequences.md)                      | TiDB 的序列实现基于 MariaDB。 |
| [`SLOW_QUERY`](/information-schema/information-schema-slow-query.md)                    | 提供有关当前 TiDB 服务器上的慢查询的信息。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| [`STATEMENTS_SUMMARY`](/statement-summary-tables.md)                                    | 类似于 MySQL 中的 performance_schema statement summary。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| [`STATEMENTS_SUMMARY_HISTORY`](/statement-summary-tables.md)                            | 类似于 MySQL 中的 performance_schema statement summary history。此表在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群上不可用。 |
| [`TABLE_STORAGE_STATS`](/information-schema/information-schema-table-storage-stats.md)  | 提供有关存储中表大小的详细信息。 |
| [`TIDB_HOT_REGIONS`](/information-schema/information-schema-tidb-hot-regions.md)        | 提供有关哪些区域是热点区域的统计信息。 |
| [`TIDB_HOT_REGIONS_HISTORY`](/information-schema/information-schema-tidb-hot-regions-history.md) | 提供有关哪些区域是热点区域的历史统计信息。 |
| [`TIDB_INDEXES`](/information-schema/information-schema-tidb-indexes.md)                | 提供有关 TiDB 表的索引信息。 |
| [`TIDB_INDEX_USAGE`](/information-schema/information-schema-tidb-index-usage.md)        | 提供 TiDB 节点上索引使用情况统计信息。 |
| [`TIDB_SERVERS_INFO`](/information-schema/information-schema-tidb-servers-info.md)      | 提供 TiDB 服务器（即 tidb-server 组件）的列表 |
| [`TIDB_TRX`](/information-schema/information-schema-tidb-trx.md) | 提供有关在 TiDB 节点上执行的事务的信息。 |
| [`TIFLASH_REPLICA`](/information-schema/information-schema-tiflash-replica.md)          | 提供有关 TiFlash 副本的详细信息。 |
| [`TIKV_REGION_PEERS`](/information-schema/information-schema-tikv-region-peers.md)      | 提供有关区域存储位置的详细信息。 |
| [`TIKV_REGION_STATUS`](/information-schema/information-schema-tikv-region-status.md)    | 提供有关区域的统计信息。 |
| [`TIKV_STORE_STATUS`](/information-schema/information-schema-tikv-store-status.md)      | 提供有关 TiKV 服务器的基本信息。 |