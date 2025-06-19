```
| └─TableRowIDScan_6(Probe)     | 1048576.00 | cop[tikv] | table:t                     | keep order:false              |
+-------------------------------+------------+-----------+-----------------------------+-------------------------------+
3 rows in set (0.00 sec)
```

### tidb_opt_prefix_index_single_scan <span class="version-mark">New in v6.4.0</span>

- Scope: SESSION | GLOBAL
- Persists to cluster: Yes
- Applies to hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): Yes
- Default value: `ON`
- 此变量控制 TiDB 优化器是否将一些过滤条件推送到前缀索引，以避免不必要的表查找并提高查询性能。
- 当此变量值设置为 `ON` 时，一些过滤条件会被推送到前缀索引。假设 `col` 列是表中的索引前缀列。查询中的 `col is null` 或 `col is not null` 条件被视为索引上的过滤条件，而不是表查找的过滤条件，从而避免了不必要的表查找。

<details>
<summary><code>tidb_opt_prefix_index_single_scan</code> 的使用示例</summary>

创建一个带有前缀索引的表：

```sql
CREATE TABLE t (a INT, b VARCHAR(10), c INT, INDEX idx_a_b(a, b(5)));
```

禁用 `tidb_opt_prefix_index_single_scan`：

```sql
SET tidb_opt_prefix_index_single_scan = 'OFF';
```

对于以下查询，执行计划使用前缀索引 `idx_a_b`，但需要表查找（出现 `IndexLookUp` 算子）。

```sql
EXPLAIN FORMAT='brief' SELECT COUNT(1) FROM t WHERE a = 1 AND b IS NOT NULL;
+-------------------------------+---------+-----------+------------------------------+-------------------------------------------------------+
| id                            | estRows | task      | access object                | operator info                                         |
+-------------------------------+---------+-----------+------------------------------+-------------------------------------------------------+
| HashAgg                       | 1.00    | root      |                              | funcs:count(Column#8)->Column#5                       |
| └─IndexLookUp                 | 1.00    | root      |                              |                                                       |
|   ├─IndexRangeScan(Build)     | 99.90   | cop[tikv] | table:t, index:idx_a_b(a, b) | range:[1 -inf,1 +inf], keep order:false, stats:pseudo |
|   └─HashAgg(Probe)            | 1.00    | cop[tikv] |                              | funcs:count(1)->Column#8                              |
|     └─Selection               | 99.90   | cop[tikv] |                              | not(isnull(test.t.b))                                 |
|       └─TableRowIDScan        | 99.90   | cop[tikv] | table:t                      | keep order:false, stats:pseudo                        |
+-------------------------------+---------+-----------+------------------------------+-------------------------------------------------------+
6 rows in set (0.00 sec)
```

启用 `tidb_opt_prefix_index_single_scan`：

```sql
SET tidb_opt_prefix_index_single_scan = 'ON';
```

启用此变量后，对于以下查询，执行计划使用前缀索引 `idx_a_b`，但不需要表查找。

```sql
EXPLAIN FORMAT='brief' SELECT COUNT(1) FROM t WHERE a = 1 AND b IS NOT NULL;
+--------------------------+---------+-----------+------------------------------+-------------------------------------------------------+
| id                       | estRows | task      | access object                | operator info                                         |
+--------------------------+---------+-----------+------------------------------+-------------------------------------------------------+
| StreamAgg                | 1.00    | root      |                              | funcs:count(Column#7)->Column#5                       |
| └─IndexReader            | 1.00    | root      |                              | index:StreamAgg                                       |
|   └─StreamAgg            | 1.00    | cop[tikv] |                              | funcs:count(1)->Column#7                              |
|     └─IndexRangeScan     | 99.90   | cop[tikv] | table:t, index:idx_a_b(a, b) | range:[1 -inf,1 +inf], keep order:false, stats:pseudo |
+--------------------------+---------+-----------+------------------------------+-------------------------------------------------------+
4 rows in set (0.00 sec)
```

</details>

### tidb_opt_projection_push_down <span class="version-mark">New in v6.1.0</span>

- Scope: SESSION
- Applies to hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): Yes
- Type: Boolean
- Default value: `OFF`
- 指定是否允许优化器将 `Projection` 下推到 TiKV 或 TiFlash coprocessor。

### tidb_opt_range_max_size <span class="version-mark">New in v6.4.0</span>

- Scope: SESSION | GLOBAL
- Persists to cluster: Yes
- Applies to hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): Yes
- Default value: `67108864` (64 MiB)
- Scope: `[0, 9223372036854775807]`
- Unit: Bytes
- 此变量用于设置优化器构建扫描范围时使用的内存上限。当变量值为 `0` 时，构建扫描范围没有内存限制。如果构建精确扫描范围消耗的内存超过限制，优化器将使用更宽松的扫描范围（例如 `[[NULL,+inf]]`）。如果执行计划没有使用精确扫描范围，您可以增加此变量的值，以使优化器构建精确扫描范围。

此变量的使用示例如下：

<details>
<summary><code>tidb_opt_range_max_size</code> 使用示例</summary>

查看此变量的默认值。从结果可以看出，优化器最多使用 64 MiB 的内存来构建扫描范围。

```sql
SELECT @@tidb_opt_range_max_size;
```

```sql
+----------------------------+
| @@tidb_opt_range_max_size |
+----------------------------+
| 67108864                   |
+----------------------------+
1 row in set (0.01 sec)
```

```sql
EXPLAIN SELECT * FROM t use index (idx) WHERE a IN (10,20,30) AND b IN (40,50,60);
```

在 64 MiB 内存上限内，优化器构建以下精确扫描范围 `[10 40,10 40], [10 50,10 50], [10 60,10 60], [20 40,20 40], [20 50,20 50], [20 60,20 60], [30 40,30 40], [30 50,30 50], [30 60,30 60]`，如下面的执行计划结果所示。

```sql
+-------------------------------+---------+-----------+--------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| id                            | estRows | task      | access object            | operator info                                                                                                                                                               |
+-------------------------------+---------+-----------+--------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| IndexLookUp_7                 | 0.90    | root      |                          |                                                                                                                                                                             |
| ├─IndexRangeScan_5(Build)     | 0.90    | cop[tikv] | table:t, index:idx(a, b) | range:[10 40,10 40], [10 50,10 50], [10 60,10 60], [20 40,20 40], [20 50,20 50], [20 60,20 60], [30 40,30 40], [30 50,30 50], [30 60,30 60], keep order:false, stats:pseudo |
```