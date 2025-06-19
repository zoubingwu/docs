- 可能的值: "json,blob,mediumblob,longblob,text,mediumtext,longtext"
- 此变量控制在执行 `ANALYZE` 命令收集统计信息时，哪些类型的列将被跳过统计信息收集。该变量仅适用于 `tidb_analyze_version = 2`。即使你使用 `ANALYZE TABLE t COLUMNS c1, ... , cn` 指定了一个列，如果该列的类型在 `tidb_analyze_skip_column_types` 中，也不会收集该列的统计信息。

```
mysql> SHOW CREATE TABLE t;
+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                                             |
+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t     | CREATE TABLE `t` (
  `a` int(11) DEFAULT NULL,
  `b` varchar(10) DEFAULT NULL,
  `c` json DEFAULT NULL,
  `d` blob DEFAULT NULL,
  `e` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin |
+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT @@tidb_analyze_skip_column_types;
+----------------------------------+
| @@tidb_analyze_skip_column_types |
+----------------------------------+
| json,blob,mediumblob,longblob    |
+----------------------------------+
1 row in set (0.00 sec)

mysql> ANALYZE TABLE t;
Query OK, 0 rows affected, 1 warning (0.05 sec)

mysql> SELECT job_info FROM mysql.analyze_jobs ORDER BY end_time DESC LIMIT 1;
+---------------------------------------------------------------------+
| job_info                                                            |
+---------------------------------------------------------------------+
| analyze table columns a, b with 256 buckets, 500 topn, 1 samplerate |
+---------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> ANALYZE TABLE t COLUMNS a, c;
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql> SELECT job_info FROM mysql.analyze_jobs ORDER BY end_time DESC LIMIT 1;
+------------------------------------------------------------------+
| job_info                                                         |
+------------------------------------------------------------------+
| analyze table columns a with 256 buckets, 500 topn, 1 samplerate |
+------------------------------------------------------------------+
1 row in set (0.00 sec)
```

### tidb_auto_analyze_end_time

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Time
- 默认值: `23:59 +0000`
- 此变量用于限制允许自动更新统计信息的时间窗口。例如，要仅允许在 UTC 时间的凌晨 1 点到凌晨 3 点之间自动更新统计信息，请设置 `tidb_auto_analyze_start_time='01:00 +0000'` 和 `tidb_auto_analyze_end_time='03:00 +0000'`。

### tidb_auto_analyze_partition_batch_size <span class="version-mark">v6.4.0 新增</span>

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 默认值: `128`。在 v7.6.0 之前，默认值为 `1`。
- 范围: `[1, 1024]`
- 此变量指定 TiDB 在分析分区表时（意味着自动收集分区表的统计信息）[自动分析](/statistics.md#automatic-update)的分区数量。
- 如果此变量的值小于分区数，TiDB 会分批自动分析分区表的所有分区。如果此变量的值大于或等于分区数，TiDB 会同时分析分区表的所有分区。
- 如果分区表的分区数远大于此变量值，并且自动分析花费的时间很长，则可以增加此变量的值以减少时间消耗。

### tidb_auto_analyze_ratio

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Float
- 默认值: `0.5`
- 范围: `(0, 1]`。 v8.0.0 及更早版本的范围是 `[0, 18446744073709551615]`。
- 此变量用于设置 TiDB 在后台线程中自动执行 [`ANALYZE TABLE`](/sql-statements/sql-statement-analyze-table.md) 以更新表统计信息的阈值。例如，值为 0.5 表示当表中超过 50% 的行被修改时，将触发自动分析。可以通过指定 `tidb_auto_analyze_start_time` 和 `tidb_auto_analyze_end_time` 将自动分析限制为仅在一天中的某些小时执行。

> **注意:**
>
> 此功能需要将系统变量 `tidb_enable_auto_analyze` 设置为 `ON`。

### tidb_auto_analyze_start_time

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Time
- 默认值: `00:00 +0000`
- 此变量用于限制允许自动更新统计信息的时间窗口。例如，要仅允许在 UTC 时间的凌晨 1 点到凌晨 3 点之间自动更新统计信息，请设置 `tidb_auto_analyze_start_time='01:00 +0000'` 和 `tidb_auto_analyze_end_time='03:00 +0000'`。

### tidb_auto_build_stats_concurrency <span class="version-mark">v6.5.0 新增</span>

- 作用域: GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `1`
- 范围: `[1, 256]`
- 此变量用于设置执行自动更新统计信息的并发度。

### tidb_backoff_lock_fast

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `10`
- 范围: `[1, 2147483647]`
- 此变量用于设置读取请求遇到锁时的 `backoff` 时间。

### tidb_backoff_weight

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Integer
- 默认值: `2`
- 范围: `[0, 2147483647]`
- 此变量用于增加 TiDB `backoff` 的最大时间权重，即遇到内部网络或其他组件（TiKV、PD）故障时，发送重试请求的最大重试时间。此变量可用于调整最大重试时间，最小值为 1。

    例如，TiDB 从 PD 获取 TSO 的基本超时时间为 15 秒。当 `tidb_backoff_weight = 2` 时，获取 TSO 的最大超时时间为：*基本时间 \* 2 = 30 秒*。

    在网络环境较差的情况下，适当增加此变量的值可以有效缓解因超时而导致的应用端错误报告。如果应用端希望更快地收到错误信息，请尽量减小此变量的值。

### tidb_batch_commit

> **警告:**
>
> **不**建议启用此变量。

- 作用域: SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: Boolean
- 默认值: `OFF`