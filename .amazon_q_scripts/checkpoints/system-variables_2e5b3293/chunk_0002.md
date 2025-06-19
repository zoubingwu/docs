- 服务器的默认字符集。

### collation_connection

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`utf8mb4_bin`
- 此变量指示当前连接中使用的排序规则。它与 MySQL 变量 `collation_connection` 一致。

### collation_database

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`utf8mb4_bin`
- 此变量指示正在使用的数据库的默认排序规则。**不建议设置此变量**。当选择一个新的数据库时，TiDB 会更改此变量的值。

### collation_server

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`utf8mb4_bin`
- 创建数据库时使用的默认排序规则。

### cte_max_recursion_depth

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：整数
- 默认值：`1000`
- 范围：`[0, 4294967295]`
- 控制公共表表达式中的最大递归深度。

### datadir

> **注意：**
>
> 此变量在 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 上不受支持。

<CustomContent platform="tidb">

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：取决于组件和部署方法。
    - `/tmp/tidb`：当你为 [`--store`](/command-line-flags-for-tidb-configuration.md#--store) 设置 `"unistore"` 时，或者如果你不设置 `--store`。
    - `${pd-ip}:${pd-port}`：当你使用 TiKV 时，这是 TiUP 和 Kubernetes 部署的 TiDB Operator 的默认存储引擎。
- 此变量指示数据存储的位置。此位置可以是本地路径 `/tmp/tidb`，或者如果数据存储在 TiKV 上，则指向 PD 服务器。`${pd-ip}:${pd-port}` 格式的值表示 TiDB 启动时连接到的 PD 服务器。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：取决于组件和部署方法。
    - `/tmp/tidb`：当你为 [`--store`](https://docs.pingcap.com/tidb/stable/command-line-flags-for-tidb-configuration#--store) 设置 `"unistore"` 时，或者如果你不设置 `--store`。
    - `${pd-ip}:${pd-port}`：当你使用 TiKV 时，这是 TiUP 和 Kubernetes 部署的 TiDB Operator 的默认存储引擎。
- 此变量指示数据存储的位置。此位置可以是本地路径 `/tmp/tidb`，或者如果数据存储在 TiKV 上，则指向 PD 服务器。`${pd-ip}:${pd-port}` 格式的值表示 TiDB 启动时连接到的 PD 服务器。

</CustomContent>

### ddl_slow_threshold

<CustomContent platform="tidb-cloud">

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

</CustomContent>

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于你当前连接的 TiDB 实例。
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`300`
- 范围：`[0, 2147483647]`
- 单位：毫秒
- 记录执行时间超过阈值的 DDL 操作。

### default_authentication_plugin

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`mysql_native_password`
- 可能的值：`mysql_native_password`、`caching_sha2_password`、`tidb_sm3_password`、`tidb_auth_token`、`authentication_ldap_sasl` 和 `authentication_ldap_simple`。
- 此变量设置服务器在建立服务器-客户端连接时声明的身份验证方法。
- 要使用 `tidb_sm3_password` 方法进行身份验证，你可以使用 [TiDB-JDBC](https://github.com/pingcap/mysql-connector-j/tree/release/8.0-sm3) 连接到 TiDB。

<CustomContent platform="tidb">

有关此变量的更多可能值，请参阅 [身份验证插件状态](/security-compatibility-with-mysql.md#authentication-plugin-status)。

</CustomContent>

### default_collation_for_utf8mb4 <span class="version-mark">v7.4.0 新增</span>

- 作用域：GLOBAL | SESSION
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：字符串
- 默认值：`utf8mb4_bin`
- 可选值：`utf8mb4_bin`、`utf8mb4_general_ci`、`utf8mb4_0900_ai_ci`
- 此变量用于设置 `utf8mb4` 字符集的默认[排序规则](/character-set-and-collation.md)。它会影响以下语句的行为：
    - [`SHOW COLLATION`](/sql-statements/sql-statement-show-collation.md) 和 [`SHOW CHARACTER SET`](/sql-statements/sql-statement-show-character-set.md) 语句中显示的默认排序规则。
    - 如果 [`CREATE TABLE`](/sql-statements/sql-statement-create-table.md) 和 [`ALTER TABLE`](/sql-statements/sql-statement-alter-table.md) 语句包含针对表或列的 `CHARACTER SET utf8mb4` 子句，但未指定排序规则，则使用此变量指定的排序规则。这不会影响不使用 `CHARACTER SET` 子句时的行为。
    - 如果 [`CREATE DATABASE`](/sql-statements/sql-statement-create-database.md) 和 [`ALTER DATABASE`](/sql-statements/sql-statement-alter-database.md) 语句包含 `CHARACTER SET utf8mb4` 子句，但未指定排序规则，则使用此变量指定的排序规则。这不会影响不使用 `CHARACTER SET` 子句时的行为。
    - 如果未使用 `COLLATE` 子句，则任何 `_utf8mb4'string'` 格式的文字字符串都使用此变量指定的排序规则。

### default_password_lifetime <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`0`
- 范围：`[0, 65535]`
- 设置自动密码过期的全局策略。默认值 `0` 表示密码永不过期。如果此系统变量设置为正整数 `N`，则表示密码有效期为 `N` 天，你必须在 `N` 天内更改密码。

### default_week_format

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`0`
- 范围：`[0, 7]`
- 设置 `WEEK()` 函数使用的星期格式。

### disconnect_on_expired_password <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`ON`
- 此变量是只读的。它指示当密码过期时，TiDB 是否断开客户端连接。如果变量设置为 `ON`，则当密码过期时，客户端连接将断开。如果变量设置为 `OFF`，则客户端连接将限制为“沙盒模式”，并且用户只能执行密码重置操作。

<CustomContent platform="tidb">

- 如果你需要更改过期密码的客户端连接的行为，请修改配置文件中的 [`security.disconnect-on-expired-password`](/tidb-configuration-file.md#disconnect-on-expired-password-new-in-v650) 配置项。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 如果你需要更改过期密码的客户端连接的默认行为，请联系 [TiDB Cloud 支持](/tidb-cloud/tidb-cloud-support.md)。

</CustomContent>