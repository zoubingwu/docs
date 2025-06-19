# TiDB 特有函数

以下函数是 TiDB 的扩展，在 MySQL 中不存在：

<CustomContent platform="tidb">

| 函数名称 | 函数描述 |
| :-------------- | :------------------------------------- |
| [`CURRENT_RESOURCE_GROUP()`](#current_resource_group)  | 返回当前会话绑定的资源组的名称。请参阅[使用资源控制实现资源隔离](/tidb-resource-control.md)。 |
| [`TIDB_BOUNDED_STALENESS()`](#tidb_bounded_staleness) | 指示 TiDB 读取指定时间范围内最新的数据。请参阅[使用 `AS OF TIMESTAMP` 子句读取历史数据](/as-of-timestamp.md)。 |
| [`TIDB_CURRENT_TSO()`](#tidb_current_tso) | 返回 TiDB 中当前的 [TimeStamp Oracle (TSO)](/tso.md)。 |
| [`TIDB_DECODE_BINARY_PLAN()`](#tidb_decode_binary_plan) | 解码二进制计划。 |
| [`TIDB_DECODE_KEY()`](#tidb_decode_key) | 将 TiDB 编码的键条目解码为包含 `_tidb_rowid` 和 `table_id` 的 JSON 结构。这些编码的键可以在一些系统表和日志输出中找到。 |
| [`TIDB_DECODE_PLAN()`](#tidb_decode_plan) | 解码 TiDB 执行计划。 |
| [`TIDB_DECODE_SQL_DIGESTS()`](#tidb_decode_sql_digests) | 查询集群中一组 SQL 摘要对应的规范化 SQL 语句（一种没有格式和参数的形式）。 |
| [`TIDB_ENCODE_SQL_DIGEST()`](#tidb_encode_sql_digest) | 获取查询字符串的摘要。 |
| [`TIDB_IS_DDL_OWNER()`](#tidb_is_ddl_owner) | 检查您连接的 TiDB 实例是否为 DDL Owner。DDL Owner 是负责代表集群中所有其他节点执行 DDL 语句的 TiDB 实例。 |
| [`TIDB_PARSE_TSO()`](#tidb_parse_tso) | 从 TiDB TSO 时间戳中提取物理时间戳。另请参阅：[`tidb_current_ts`](/system-variables.md#tidb_current_ts)。 |
| [`TIDB_PARSE_TSO_LOGICAL()`](#tidb_parse_tso_logical) | 从 TiDB TSO 时间戳中提取逻辑时间戳。 |
| [`TIDB_ROW_CHECKSUM()`](#tidb_row_checksum) | 查询行的校验和值。此函数只能在 FastPlan 进程中的 `SELECT` 语句中使用。也就是说，您可以通过 `SELECT TIDB_ROW_CHECKSUM() FROM t WHERE id = ?` 或 `SELECT TIDB_ROW_CHECKSUM() FROM t WHERE id IN (?, ?, ...)` 等语句进行查询。另请参阅：[单行数据的数据完整性验证](/ticdc/ticdc-integrity-check.md)。 |
| [`TIDB_SHARD()`](#tidb_shard) | 创建一个分片索引来分散索引热点。分片索引是以 `TIDB_SHARD` 函数作为前缀的表达式索引。|
| [`TIDB_VERSION()`](#tidb_version) | 返回包含其他构建信息的 TiDB 版本。 |
| [`VITESS_HASH()`](#vitess_hash) | 返回数字的哈希值。此函数与 Vitess 的 `HASH` 函数兼容，旨在帮助从 Vitess 迁移数据。 |

</CustomContent>

<CustomContent platform="tidb-cloud">

| 函数名称 | 函数描述 |
| :-------------- | :------------------------------------- |
| [`CURRENT_RESOURCE_GROUP()`](#current_resource_group)  | 返回当前会话绑定的资源组的名称。请参阅[使用资源控制实现资源隔离](/tidb-resource-control.md)。 |
| [`TIDB_BOUNDED_STALENESS()`](#tidb_bounded_staleness) | 指示 TiDB 读取指定时间范围内最新的数据。请参阅[使用 `AS OF TIMESTAMP` 子句读取历史数据](/as-of-timestamp.md)。 |
| [`TIDB_CURRENT_TSO()`](#tidb_current_tso) | 返回 TiDB 中当前的 [TimeStamp Oracle (TSO)](/tso.md)。 |
| [`TIDB_DECODE_BINARY_PLAN()`](#tidb_decode_binary_plan) | 解码二进制计划。 |
| [`TIDB_DECODE_KEY()`](#tidb_decode_key) | 将 TiDB 编码的键条目解码为包含 `_tidb_rowid` 和 `table_id` 的 JSON 结构。这些编码的键可以在一些系统表和日志输出中找到。 |
| [`TIDB_DECODE_PLAN()`](#tidb_decode_plan) | 解码 TiDB 执行计划。 |
| [`TIDB_DECODE_SQL_DIGESTS()`](#tidb_decode_sql_digests) | 查询集群中一组 SQL 摘要对应的规范化 SQL 语句（一种没有格式和参数的形式）。 |
| [`TIDB_ENCODE_SQL_DIGEST()`](#tidb_encode_sql_digest) | 获取查询字符串的摘要。 |
| [`TIDB_IS_DDL_OWNER()`](#tidb_is_ddl_owner) | 检查您连接的 TiDB 实例是否为 DDL Owner。DDL Owner 是负责代表集群中所有其他节点执行 DDL 语句的 TiDB 实例。 |
| [`TIDB_PARSE_TSO()`](#tidb_parse_tso) | 从 TiDB TSO 时间戳中提取物理时间戳。另请参阅：[`tidb_current_ts`](/system-variables.md#tidb_current_ts)。 |
| [`TIDB_PARSE_TSO_LOGICAL()`](#tidb_parse_tso_logical) | 从 TiDB TSO 时间戳中提取逻辑时间戳。 |
| [`TIDB_ROW_CHECKSUM()`](#tidb_row_checksum) | 查询行的校验和值。此函数只能在 FastPlan 进程中的 `SELECT` 语句中使用。也就是说，您可以通过 `SELECT TIDB_ROW_CHECKSUM() FROM t WHERE id = ?` 或 `SELECT TIDB_ROW_CHECKSUM() FROM t WHERE id IN (?, ?, ...)` 等语句进行查询。另请参阅：[单行数据的数据完整性验证](https://docs.pingcap.com/tidb/stable/ticdc-integrity-check)。 |
| [`TIDB_SHARD()`](#tidb_shard) | 创建一个分片索引来分散索引热点。分片索引是以 `TIDB_SHARD` 函数作为前缀的表达式索引。|
| [`TIDB_VERSION()`](#tidb_version) | 返回包含其他构建信息的 TiDB 版本。 |
| [`VITESS_HASH()`](#vitess_hash) | 返回数字的哈希值。此函数与 Vitess 的 `HASH` 函数兼容，旨在帮助从 Vitess 迁移数据。 |

</CustomContent>