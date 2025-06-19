## TIDB_IS_DDL_OWNER

`TIDB_IS_DDL_OWNER()` 函数用于判断你当前连接的实例是否为 DDL Owner，如果是则返回 `1`。

```sql
SELECT TIDB_IS_DDL_OWNER();
```

```
+---------------------+
| TIDB_IS_DDL_OWNER() |
+---------------------+
|                   1 |
+---------------------+
1 row in set (0.00 sec)
```