# Information Schema

Information Schema 提供了一种 ANSI 标准的方式来查看系统元数据。除了为了与 MySQL 兼容而包含的表之外，TiDB 还提供了一些自定义的 `INFORMATION_SCHEMA` 表。

许多 `INFORMATION_SCHEMA` 表都有相应的 `SHOW` 语句。查询 `INFORMATION_SCHEMA` 的好处是可以进行表之间的连接。