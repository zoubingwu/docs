- 类型：整数
- 默认值：`0`
- 范围：`[0, 2147483647]`
- 此变量用于为 `RAND()` SQL 函数中使用的随机值生成器设定种子。
- 此变量的行为与 MySQL 兼容。

### rand_seed2

- 范围：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`0`
- 范围：`[0, 2147483647]`
- 此变量用于为 `RAND()` SQL 函数中使用的随机值生成器设定种子。
- 此变量的行为与 MySQL 兼容。

### require_secure_transport <span class="version-mark">v6.1.0 新增</span>

> **注意：**
>
> 目前，[TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 不支持此变量。请**勿**为 TiDB Cloud Dedicated 集群启用此变量。否则，可能会导致 SQL 客户端连接失败。此限制是一项临时控制措施，将在未来的版本中解决。

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：对于 TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `OFF`，对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `ON`

<CustomContent platform="tidb">

- 此变量确保所有与 TiDB 的连接要么在本地套接字上，要么使用 TLS。有关更多详细信息，请参阅[启用 TiDB 客户端和服务器之间的 TLS](/enable-tls-between-clients-and-servers.md)。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 此变量确保所有与 TiDB 的连接要么在本地套接字上，要么使用 TLS。

</CustomContent>

- 将此变量设置为 `ON` 需要你从启用了 TLS 的会话连接到 TiDB。这有助于防止在 TLS 配置不正确时出现锁定情况。
- 此设置以前是一个 `tidb.toml` 选项 (`security.require-secure-transport`)，但从 TiDB v6.1.0 开始更改为系统变量。
- 从 v6.5.6、v7.1.2、v7.5.1 和 v8.0.0 开始，当启用安全增强模式 (SEM) 时，禁止将此变量设置为 `ON`，以避免用户潜在的连接问题。

### skip_name_resolve <span class="version-mark">v5.2.0 新增</span>

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`
- 此变量控制 `tidb-server` 实例是否在连接握手过程中解析主机名。
- 当 DNS 不可靠时，你可以启用此选项以提高网络性能。

> **注意：**
>
> 当 `skip_name_resolve=ON` 时，身份中包含主机名的用户将无法再登录到服务器。例如：
>
> ```sql
> CREATE USER 'appuser'@'apphost' IDENTIFIED BY 'app-password';
> ```
>
> 在此示例中，建议将 `apphost` 替换为 IP 地址或通配符 (`%`)。

### socket

- 范围：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- `tidb-server` 在使用 MySQL 协议时监听的本地 unix 套接字文件。

### sql_log_bin

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`ON`
- 指示是否将更改写入 [TiDB Binlog](https://docs.pingcap.com/tidb/stable/tidb-binlog-overview)。

> **注意：**
>
> 不建议将 `sql_log_bin` 设置为全局变量，因为未来版本的 TiDB 可能只允许将其设置为会话变量。

### sql_mode

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：`ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION`
- 此变量控制许多 MySQL 兼容性行为。有关更多信息，请参阅 [SQL Mode](/sql-mode.md)。

### sql_require_primary_key <span class="version-mark">v6.3.0 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔值
- 默认值：`OFF`
- 此变量控制是否强制要求表具有主键。启用此变量后，尝试创建或更改没有主键的表将产生错误。
- 此功能基于 MySQL 8.0 中类似命名的 [`sql_require_primary_key`](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_sql_require_primary_key)。
- 强烈建议在使用 TiCDC 时启用此变量。这是因为将更改复制到 MySQL sink 需要表具有主键。

<CustomContent platform="tidb">

- 如果你启用此变量并使用 TiDB Data Migration (DM) 迁移数据，建议你将 `sql_require_ primary_key` 添加到 [DM 任务配置文件](/dm/task-configuration-file-full.md#task-configuration-file-template-advanced) 的 `session` 部分，并将其设置为 `OFF`。否则，将导致 DM 无法创建任务。

</CustomContent>

### sql_select_limit <span class="version-mark">v4.0.2 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`18446744073709551615`
- 范围：`[0, 18446744073709551615]`
- 单位：行
- `SELECT` 语句返回的最大行数。

### ssl_ca

<CustomContent platform="tidb">

- 范围：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 证书颁发机构文件的位置（如果有）。此变量的值由 TiDB 配置文件项 [`ssl-ca`](/tidb-configuration-file.md#ssl-ca) 定义。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 范围：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 证书颁发机构文件的位置（如果有）。此变量的值由 TiDB 配置文件项 [`ssl-ca`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#ssl-ca) 定义。

</CustomContent>

### ssl_cert

<CustomContent platform="tidb">

- 范围：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 用于 SSL/TLS 连接的证书文件的位置（如果有文件）。此变量的值由 TiDB 配置文件项 [`ssl-cert`](/tidb-configuration-file.md#ssl-cert) 定义。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 范围：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 用于 SSL/TLS 连接的证书文件的位置（如果有文件）。此变量的值由 TiDB 配置文件项 [`ssl-cert`](https://docs.pingcap.com/tidb/stable/tidb-configuration-file#ssl-cert) 定义。

</CustomContent>

### ssl_key

<CustomContent platform="tidb">

- 范围：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""