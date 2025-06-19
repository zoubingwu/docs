## VITESS_HASH

`VITESS_HASH(num)` 函数用于以与 Vitess 相同的方式哈希一个数字。这有助于从 Vitess 迁移到 TiDB。

示例：

```sql
SELECT VITESS_HASH(123);
```

```
+---------------------+
| VITESS_HASH(123)    |
+---------------------+
| 1155070131015363447 |
+---------------------+
1 row in set (0.00 sec)
```