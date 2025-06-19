## TIDB_PARSE_TSO

`TIDB_PARSE_TSO()` 函数从 TiDB TSO 时间戳中提取物理时间戳。[TSO](/tso.md) 代表时间戳预言机（Time Stamp Oracle），是由 PD (Placement Driver) 为每个事务发出的单调递增的时间戳。

TSO 是一个由两部分组成的数字：

- 一个物理时间戳
- 一个逻辑计数器

```sql
BEGIN;
SELECT TIDB_PARSE_TSO(@@tidb_current_ts);
ROLLBACK;
```

```sql
+-----------------------------------+
| TIDB_PARSE_TSO(@@tidb_current_ts) |
+-----------------------------------+
| 2021-05-26 11:33:37.776000        |
+-----------------------------------+
1 row in set (0.0012 sec)
```

这里 `TIDB_PARSE_TSO` 用于从 `tidb_current_ts` 会话变量中可用的时间戳数字中提取物理时间戳。因为时间戳是为每个事务发出的，所以此函数在事务中运行。