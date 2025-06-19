## TIDB_ROW_CHECKSUM

`TIDB_ROW_CHECKSUM()` 函数用于查询行的校验和值。此函数只能在 FastPlan 进程中的 `SELECT` 语句中使用。也就是说，你可以通过类似 `SELECT TIDB_ROW_CHECKSUM() FROM t WHERE id = ?` 或 `SELECT TIDB_ROW_CHECKSUM() FROM t WHERE id IN (?, ?, ...)` 的语句进行查询。

要启用 TiDB 中单行数据的校验和功能（由系统变量 [`tidb_enable_row_level_checksum`](/system-variables.md#tidb_enable_row_level_checksum-new-in-v710) 控制），请运行以下语句：

```sql
SET GLOBAL tidb_enable_row_level_checksum = ON;
```

此配置仅对新创建的会话生效，因此你需要重新连接到 TiDB。

创建表 `t` 并插入数据：

```sql
USE test;
CREATE TABLE t (id INT PRIMARY KEY, k INT, c CHAR(1));
INSERT INTO t VALUES (1, 10, 'a');
```

以下语句展示了如何查询表 `t` 中 `id = 1` 的行的校验和值：

```sql
SELECT *, TIDB_ROW_CHECKSUM() FROM t WHERE id = 1;
```

输出如下：

```sql
+----+------+------+---------------------+
| id | k    | c    | TIDB_ROW_CHECKSUM() |
+----+------+------+---------------------+
|  1 |   10 | a    | 3813955661          |
+----+------+------+---------------------+
1 row in set (0.000 sec)
```