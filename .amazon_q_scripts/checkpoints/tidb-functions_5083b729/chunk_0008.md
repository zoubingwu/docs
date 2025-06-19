## TIDB_DECODE_SQL_DIGESTS

`TIDB_DECODE_SQL_DIGESTS()` 函数用于查询集群中 SQL 摘要集合对应的规范化 SQL 语句（一种不包含格式和参数的形式）。此函数接受 1 个或 2 个参数：

* `digests`: 一个字符串。此参数的格式为 JSON 字符串数组，数组中的每个字符串都是一个 SQL 摘要。
* `stmtTruncateLength`: 一个整数（可选）。它用于限制返回结果中每个 SQL 语句的长度。如果 SQL 语句超过指定的长度，则该语句将被截断。`0` 表示长度不受限制。

此函数返回一个字符串，其格式为 JSON 字符串数组。数组中的第 *i* 项是 `digests` 参数中第 *i* 个元素对应的规范化 SQL 语句。如果 `digests` 参数中的某个元素不是有效的 SQL 摘要，或者系统无法找到相应的 SQL 语句，则返回结果中对应的项为 `null`。如果指定了截断长度 (`stmtTruncateLength > 0`)，对于返回结果中超过此长度的每个语句，将保留前 `stmtTruncateLength` 个字符，并在末尾添加 `"..."` 后缀以指示截断。如果 `digests` 参数为 `NULL`，则该函数的返回值为 `NULL`。

> **注意：**
>
> * 只有具有 [PROCESS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_process) 权限的用户才能使用此函数。
> * 当执行 `TIDB_DECODE_SQL_DIGESTS` 时，TiDB 会从语句摘要表中查询每个 SQL 摘要对应的语句，因此不能保证始终可以为任何 SQL 摘要找到相应的语句。只能找到在集群中执行过的语句，并且是否可以查询到这些 SQL 语句也受到语句摘要表相关配置的影响。有关语句摘要表的详细描述，请参见 [语句摘要表](/statement-summary-tables.md)。
> * 此函数开销很高。在具有大量行的查询中（例如，在大规模且繁忙的集群上查询 `information_schema.cluster_tidb_trx` 的全表），使用此函数可能会导致查询运行时间过长。请谨慎使用。
>     * 此函数开销很高，因为它每次调用时，都会在内部查询 `STATEMENTS_SUMMARY`、`STATEMENTS_SUMMARY_HISTORY`、`CLUSTER_STATEMENTS_SUMMARY` 和 `CLUSTER_STATEMENTS_SUMMARY_HISTORY` 表，并且查询涉及 `UNION` 操作。此函数目前不支持向量化，也就是说，当为多行数据调用此函数时，上述查询会为每一行单独执行。

```sql
SET @digests = '["e6f07d43b5c21db0fbb9a31feac2dc599787763393dd5acbfad80e247eb02ad5","38b03afa5debbdf0326a014dbe5012a62c51957f1982b3093e748460f8b00821","e5796985ccafe2f71126ed6c0ac939ffa015a8c0744a24b7aee6d587103fd2f7"]';

SELECT TIDB_DECODE_SQL_DIGESTS(@digests);
```

```sql
+------------------------------------+
| TIDB_DECODE_SQL_DIGESTS(@digests)  |
+------------------------------------+
| ["begin",null,"select * from `t`"] |
+------------------------------------+
1 row in set (0.00 sec)
```

在上面的示例中，参数是一个包含 3 个 SQL 摘要的 JSON 数组，相应的 SQL 语句是查询结果中的三个项。但是无法从集群中找到与第二个 SQL 摘要对应的 SQL 语句，因此结果中的第二项为 `null`。

```sql
SELECT TIDB_DECODE_SQL_DIGESTS(@digests, 10);
```

```sql
+---------------------------------------+
| TIDB_DECODE_SQL_DIGESTS(@digests, 10) |
+---------------------------------------+
| ["begin",null,"select * f..."]        |
+---------------------------------------+
1 row in set (0.01 sec)
```

上面的调用将第二个参数（即截断长度）指定为 10，并且查询结果中第三个语句的长度大于 10。因此，仅保留前 10 个字符，并在末尾添加 `"..."`，表示截断。

另请参阅：

- [语句摘要表](/statement-summary-tables.md)
- [`INFORMATION_SCHEMA.TIDB_TRX`](/information-schema/information-schema-tidb-trx.md)