---
title: 系统变量
summary: 使用系统变量来优化性能或改变运行行为。
---

# 系统变量

TiDB 系统变量的行为与 MySQL 类似，设置应用于 `SESSION` 或 `GLOBAL` 范围：

- 在 `SESSION` 范围内的更改只会影响当前会话。
- 在 `GLOBAL` 范围内的更改会立即生效。如果此变量也是 `SESSION` 范围的，则所有会话（包括您的会话）将继续使用其当前的会话值。
- 使用 [`SET` 语句](/sql-statements/sql-statement-set-variable.md) 进行更改：

```sql
# 这两个相同的语句更改会话变量
SET tidb_distsql_scan_concurrency = 10;
SET SESSION tidb_distsql_scan_concurrency = 10;

# 这两个相同的语句更改全局变量
SET @@global.tidb_distsql_scan_concurrency = 10;
SET GLOBAL tidb_distsql_scan_concurrency = 10;
```

> **注意：**
>
> 几个 `GLOBAL` 变量会持久化到 TiDB 集群。本文档中的某些变量具有“持久化到集群”设置，可以配置为“是”或“否”。
>
> - 对于“持久化到集群：是”的变量，当全局变量更改时，会向所有 TiDB 服务器发送通知以刷新其系统变量缓存。当您添加其他 TiDB 服务器或重新启动现有 TiDB 服务器时，将自动使用持久化的配置值。
> - 对于“持久化到集群：否”的变量，更改仅适用于您连接到的本地 TiDB 实例。要保留任何设置的值，您需要在 `tidb.toml` 配置文件中指定这些变量。
>
> 此外，TiDB 将几个 MySQL 变量显示为可读和可设置。这是兼容性所必需的，因为应用程序和连接器通常会读取 MySQL 变量。例如，JDBC 连接器会读取和设置查询缓存设置，尽管不依赖于该行为。

> **注意：**
>
> 较大的值并不总是能带来更好的性能。同样重要的是要考虑执行语句的并发连接数，因为大多数设置都适用于每个连接。
>
> 在确定安全值时，请考虑变量的单位：
>
> * 对于线程，安全值通常最多为 CPU 核心数。
> * 对于字节，安全值通常小于系统内存量。
> * 对于时间，请注意单位可能是秒或毫秒。
>
> 使用相同单位的变量可能会争用同一组资源。

从 v7.4.0 开始，您可以使用 [`SET_VAR`](/optimizer-hints.md#set_varvar_namevar_value) 在语句执行期间临时修改某些 `SESSION` 变量的值。语句执行完毕后，当前会话中系统变量的值会自动更改回原始值。此 hint 可用于修改一些与优化器和执行器相关的系统变量。本文档中的变量具有“适用于 hint SET_VAR”设置，可以配置为“是”或“否”。

- 对于“适用于 hint SET_VAR：是”的变量，您可以使用 [`SET_VAR`](/optimizer-hints.md#set_varvar_namevar_value) hint 在语句执行期间修改当前会话中系统变量的值。
- 对于“适用于 hint SET_VAR：否”的变量，您不能使用 [`SET_VAR`](/optimizer-hints.md#set_varvar_namevar_value) hint 在语句执行期间修改当前会话中系统变量的值。

有关 `SET_VAR` hint 的更多信息，请参阅 [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)。

## 变量参考

### allow_auto_random_explicit_insert <span class="version-mark">v4.0.3 新增</span>

- 范围：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔
- 默认值：`OFF`
- 确定是否允许在 `INSERT` 语句中显式指定具有 `AUTO_RANDOM` 属性的列的值。

### authentication_ldap_sasl_auth_method_name <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`SCRAM-SHA-1`
- 可能的值：`SCRAM-SHA-1`、`SCRAM-SHA-256` 和 `GSSAPI`。
- 对于 LDAP SASL 身份验证，此变量指定身份验证方法名称。

### authentication_ldap_sasl_bind_base_dn <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：字符串
- 默认值：""
- 对于 LDAP SASL 身份验证，此变量限制搜索树内的搜索范围。如果创建用户时没有 `AS ...` 子句，TiDB 将根据用户名自动在 LDAP 服务器中搜索 `dn`。

### authentication_ldap_sasl_bind_root_dn <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：字符串
- 默认值：""
- 对于 LDAP SASL 身份验证，此变量指定用于登录到 LDAP 服务器以搜索用户的 `dn`。

### authentication_ldap_sasl_bind_root_pwd <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：字符串
- 默认值：""
- 对于 LDAP SASL 身份验证，此变量指定用于登录到 LDAP 服务器以搜索用户的密码。

### authentication_ldap_sasl_ca_path <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：字符串
- 默认值：""
- 对于 LDAP SASL 身份验证，此变量指定 StartTLS 连接的证书颁发机构文件的绝对路径。

### authentication_ldap_sasl_init_pool_size <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`10`
- 范围：`[1, 32767]`
- 对于 LDAP SASL 身份验证，此变量指定 LDAP 服务器连接池中的初始连接数。

### authentication_ldap_sasl_max_pool_size <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`1000`
- 范围：`[1, 32767]`
- 对于 LDAP SASL 身份验证，此变量指定 LDAP 服务器连接池中的最大连接数。

### authentication_ldap_sasl_server_host <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：字符串
- 默认值：""
- 对于 LDAP SASL 身份验证，此变量指定 LDAP 服务器主机名或 IP 地址。

### authentication_ldap_sasl_server_port <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：整数
- 默认值：`389`
- 范围：`[1, 65535]`
- 对于 LDAP SASL 身份验证，此变量指定 LDAP 服务器的 TCP/IP 端口号。

### authentication_ldap_sasl_tls <span class="version-mark">v7.1.0 新增</span>

- 范围：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：布尔
- 默认值：`OFF`
- 对于 LDAP SASL 身份验证，此变量控制插件与 LDAP 服务器的连接是否受 StartTLS 保护。