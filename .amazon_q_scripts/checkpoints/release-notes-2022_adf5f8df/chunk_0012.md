## 2022年10月25日

**常规变更**

- 支持动态更改和持久化 TiDB 系统变量的子集（beta）。

    您可以使用标准 SQL 语句为支持的系统变量设置新值。

    ```sql
    SET [GLOBAL|SESSION] <variable>
    ```

    例如：

    ```sql
    SET GLOBAL tidb_committer_concurrency = 127;
    ```

    如果在 `GLOBAL` 级别设置变量，则该变量将应用于集群并持久化（即使在您重新启动或重新加载服务器后仍保持有效）。`SESSION` 级别的变量不是持久的，仅在当前会话中有效。

    **此功能仍处于 beta 阶段**，仅支持有限数量的变量。不建议修改其他 [系统变量](/system-variables.md)，因为存在不确定性的副作用。请参阅以下列表，了解基于 TiDB v6.1 的所有支持的变量：

    - [`require_secure_transport`](/system-variables.md#require_secure_transport-new-in-v610)
    - [`tidb_committer_concurrency`](/system-variables.md#tidb_committer_concurrency-new-in-v610)
    - [`tidb_enable_batch_dml`](/system-variables.md#tidb_enable_batch_dml)
    - [`tidb_enable_prepared_plan_cache`](/system-variables.md#tidb_enable_prepared_plan_cache-new-in-v610)
    - [`tidb_max_tiflash_threads`](/system-variables.md#tidb_max_tiflash_threads-new-in-v610)
    - [`tidb_mem_oom_action`](/system-variables.md#tidb_mem_oom_action-new-in-v610)
    - [`tidb_mem_quota_query`](/system-variables.md#tidb_mem_quota_query)
    - [`tidb_prepared_plan_cache_size`](/system-variables.md#tidb_prepared_plan_cache_size-new-in-v610)
    - [`tidb_query_log_max_len`](/system-variables.md#tidb_query_log_max_len)

- 将新的 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v6.1.1](https://docs.pingcap.com/tidb/stable/release-6.1.1) 升级到 [v6.1.2](https://docs.pingcap.com/tidb/stable/release-6.1.2)。