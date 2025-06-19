## TIDB_VERSION

`TIDB_VERSION()` 函数用于获取你所连接的 TiDB 服务器的版本和构建详情。你可以在 GitHub 上报告问题时使用此函数。

```sql
SELECT TIDB_VERSION()\G
```

```sql
*************************** 1. row ***************************
TIDB_VERSION(): Release Version: v8.1.2
Edition: Community
Git Commit Hash: 821e491a20fbab36604b36b647b5bae26a2c1418
Git Branch: HEAD
UTC Build Time: 2024-12-26 19:16:25
GoVersion: go1.21.10
Race Enabled: false
Check Table Before Drop: false
Store: tikv
1 row in set (0.00 sec)
```