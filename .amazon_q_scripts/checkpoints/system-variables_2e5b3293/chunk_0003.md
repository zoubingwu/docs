### div_precision_increment <span class="version-mark">v8.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`4`
- 取值范围：`[0, 30]`
- 该变量指定使用 `/` 运算符执行除法运算时，结果的小数位数增加的位数。该变量与 MySQL 相同。

### error_count

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 一个只读变量，指示生成消息的最后一个语句产生的错误数。

### foreign_key_checks

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：v6.6.0 之前，默认值为 `OFF`。从 v6.6.0 开始，默认值为 `ON`。
- 该变量控制是否启用外键约束检查。

### group_concat_max_len

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1024`
- 取值范围：`[4, 18446744073709551615]`
- `GROUP_CONCAT()` 函数中项目的最大缓冲区大小。

### have_openssl

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`DISABLED`
- 用于 MySQL 兼容性的只读变量。当服务器启用 TLS 时，服务器将其设置为 `YES`。

### have_ssl

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`DISABLED`
- 用于 MySQL 兼容性的只读变量。当服务器启用 TLS 时，服务器将其设置为 `YES`。

### hostname

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：（系统主机名）
- TiDB 服务器的主机名，作为只读变量。

### identity <span class="version-mark">v5.3.0 新增</span>

该变量是 [`last_insert_id`](#last_insert_id) 的别名。

### init_connect

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- `init_connect` 功能允许在首次连接到 TiDB 服务器时自动执行 SQL 语句。如果您具有 `CONNECTION_ADMIN` 或 `SUPER` 权限，则不会执行此 `init_connect` 语句。如果 `init_connect` 语句导致错误，您的用户连接将被终止。

### innodb_lock_wait_timeout

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`50`
- 取值范围：`[1, 3600]`
- 单位：秒
- 悲观事务的锁等待超时时间（默认）。

### interactive_timeout

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`28800`
- 取值范围：`[1, 31536000]`
- 单位：秒
- 此变量表示交互式用户会话的空闲超时时间。交互式用户会话是指通过使用 `CLIENT_INTERACTIVE` 选项调用 [`mysql_real_connect()`](https://dev.mysql.com/doc/c-api/5.7/en/mysql-real-connect.html) API 建立的会话（例如，MySQL Shell 和 MySQL Client）。此变量与 MySQL 完全兼容。

### last_insert_id

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 取值范围：`[0, 18446744073709551615]`
- 此变量返回由 insert 语句生成的最后一个 `AUTO_INCREMENT` 或 `AUTO_RANDOM` 值。
- `last_insert_id` 的值与函数 `LAST_INSERT_ID()` 返回的值相同。

### last_plan_from_binding <span class="version-mark">v4.0 新增</span>

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于显示先前语句中使用的执行计划是否受到 [计划绑定](/sql-plan-management.md) 的影响。

### last_plan_from_cache <span class="version-mark">v4.0 新增</span>

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量用于显示先前 `execute` 语句中使用的执行计划是否直接从计划缓存中获取。

### last_sql_use_alloc <span class="version-mark">v6.4.0 新增</span>

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`OFF`
- 此变量是只读的。它用于显示先前的语句是否使用了缓存的 chunk 对象（chunk 分配）。

### license

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`Apache License 2.0`
- 此变量指示 TiDB 服务器安装的许可证。

### log_bin

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量指示是否使用 [TiDB Binlog](https://docs.pingcap.com/tidb/stable/tidb-binlog-overview)。

### max_allowed_packet <span class="version-mark">v6.1.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`67108864`
- 取值范围：`[1024, 1073741824]`
- 该值应为 1024 的整数倍。如果该值不能被 1024 整除，则会提示警告，并且该值将被向下舍入。例如，当该值设置为 1025 时，TiDB 中的实际值为 1024。
- 服务器和客户端在一次数据包传输中允许的最大数据包大小。
- 在 `SESSION` 作用域中，此变量是只读的。
- 此变量与 MySQL 兼容。

### password_history <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 取值范围：`[0, 4294967295]`
- 此变量用于建立密码重用策略，允许 TiDB 根据密码更改的次数限制密码重用。默认值 `0` 表示禁用基于密码更改次数的密码重用策略。当此变量设置为正整数 `N` 时，不允许重用最近 `N` 个密码。

### mpp_exchange_compression_mode <span class="version-mark">v6.6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：`UNSPECIFIED`
- 取值选项：`NONE`，`FAST`，`HIGH_COMPRESSION`，`UNSPECIFIED`
- 此变量用于指定 MPP Exchange 算子的数据压缩模式。当 TiDB 选择版本号为 `1` 的 MPP 执行计划时，此变量生效。变量值的含义如下：
    - `UNSPECIFIED`：表示未指定。TiDB 将自动选择压缩模式。目前，TiDB 自动选择 `FAST` 模式。
    - `NONE`：不使用数据压缩。
    - `FAST`：快速模式。整体性能良好，压缩率低于 `HIGH_COMPRESSION`。