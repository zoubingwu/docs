## TIDB_SHARD

`TIDB_SHARD()` 函数用于创建 shard 索引，以分散索引热点。shard 索引是以 `TIDB_SHARD()` 函数为前缀的表达式索引。

- 创建：

    要为索引字段 `a` 创建 shard 索引，可以使用 `uk((tidb_shard(a)), a))`。当唯一二级索引 `uk((tidb_shard(a)), a))` 中的索引字段 `a` 上存在由单调递增或递减数据引起的热点时，索引的前缀 `tidb_shard(a)` 可以分散热点，从而提高集群的可扩展性。

- 场景：

    - 唯一二级索引上存在由单调递增或递减的键引起的写入热点，并且该索引包含整数类型字段。
    - SQL 语句基于二级索引的所有字段执行等值查询，无论是单独的 `SELECT` 还是由 `UPDATE`、`DELETE` 等生成的内部查询。等值查询包括两种方式：`a = 1` 或 `a IN (1, 2, ......)`。

- 限制：

    - 不能用于不等值查询。
    - 不能用于包含 `OR` 且与最外层 `AND` 运算符混合的查询。
    - 不能用于 `GROUP BY` 子句。
    - 不能用于 `ORDER BY` 子句。
    - 不能用于 `ON` 子句。
    - 不能用于 `WHERE` 子查询。
    - 只能用于分散整数字段的唯一索引。
    - 可能在复合索引中不起作用。
    - 不能通过 FastPlan 过程，这会影响优化器性能。
    - 不能用于准备执行计划缓存。

以下示例展示了如何使用 `TIDB_SHARD()` 函数。

- 使用 `TIDB_SHARD()` 函数计算 SHARD 值。

    以下语句展示了如何使用 `TIDB_SHARD()` 函数计算 `12373743746` 的 SHARD 值：

    ```sql
    SELECT TIDB_SHARD(12373743746);
    ```

- SHARD 值为：

    ```sql
    +-------------------------+
    | TIDB_SHARD(12373743746) |
    +-------------------------+
    |                     184 |
    +-------------------------+
    1 row in set (0.00 sec)
    ```

- 使用 `TIDB_SHARD()` 函数创建 shard 索引：

    ```sql
    CREATE TABLE test(id INT PRIMARY KEY CLUSTERED, a INT, b INT, UNIQUE KEY uk((tidb_shard(a)), a));
    ```