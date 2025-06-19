## TIDB_CURRENT_TSO

`TIDB_CURRENT_TSO()` 函数返回当前事务的 [TSO](/tso.md)。这类似于 [`tidb_current_ts`](/system-variables.md#tidb_current_ts) 系统变量。

```sql
BEGIN;
```

```
Query OK, 0 rows affected (0.00 sec)
```

```sql
SELECT TIDB_CURRENT_TSO();
```

```
+--------------------+
| TIDB_CURRENT_TSO() |
+--------------------+
| 450456244814610433 |
+--------------------+
1 row in set (0.00 sec)
```

```sql
SELECT @@tidb_current_ts;
```

```
+--------------------+
| @@tidb_current_ts  |
+--------------------+
| 450456244814610433 |
+--------------------+
1 row in set (0.00 sec)
```