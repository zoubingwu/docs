### authentication_ldap_simple_auth_method_name <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 枚举
- 默认值: `SIMPLE`
- 可选值: `SIMPLE`。
- 对于 LDAP 简单认证，此变量指定认证方法名称。唯一支持的值是 `SIMPLE`。

### authentication_ldap_simple_bind_base_dn <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 字符串
- 默认值: ""
- 对于 LDAP 简单认证，此变量限制搜索树内的搜索范围。如果用户创建时没有使用 `AS ...` 子句，TiDB 将根据用户名自动在 LDAP 服务器中搜索 `dn`。

### authentication_ldap_simple_bind_root_dn <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 字符串
- 默认值: ""
- 对于 LDAP 简单认证，此变量指定用于登录 LDAP 服务器以搜索用户的 `dn`。

### authentication_ldap_simple_bind_root_pwd <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 字符串
- 默认值: ""
- 对于 LDAP 简单认证，此变量指定用于登录 LDAP 服务器以搜索用户的密码。

### authentication_ldap_simple_ca_path <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 字符串
- 默认值: ""
- 对于 LDAP 简单认证，此变量指定 StartTLS 连接的证书颁发机构文件的绝对路径。

### authentication_ldap_simple_init_pool_size <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 整数
- 默认值: `10`
- 范围: `[1, 32767]`
- 对于 LDAP 简单认证，此变量指定到 LDAP 服务器的连接池中的初始连接数。

### authentication_ldap_simple_max_pool_size <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 整数
- 默认值: `1000`
- 范围: `[1, 32767]`
- 对于 LDAP 简单认证，此变量指定到 LDAP 服务器的连接池中的最大连接数。

### authentication_ldap_simple_server_host <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 字符串
- 默认值: ""
- 对于 LDAP 简单认证，此变量指定 LDAP 服务器主机名或 IP 地址。

### authentication_ldap_simple_server_port <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 整数
- 默认值: `389`
- 范围: `[1, 65535]`
- 对于 LDAP 简单认证，此变量指定 LDAP 服务器的 TCP/IP 端口号。

### authentication_ldap_simple_tls <span class="version-mark">v7.1.0 新增</span>

- 作用域: GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 布尔值
- 默认值: `OFF`
- 对于 LDAP 简单认证，此变量控制插件到 LDAP 服务器的连接是否受 StartTLS 保护。

### auto_increment_increment

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 整数
- 默认值: `1`
- 范围: `[1, 65535]`
- 控制分配给列的 `AUTO_INCREMENT` 值的步长，以及 `AUTO_RANDOM` ID 的分配规则。通常与 [`auto_increment_offset`](#auto_increment_offset) 结合使用。

### auto_increment_offset

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 整数
- 默认值: `1`
- 范围: `[1, 65535]`
- 控制分配给列的 `AUTO_INCREMENT` 值的初始偏移量，以及 `AUTO_RANDOM` ID 的分配规则。此设置通常与 [`auto_increment_increment`](#auto_increment_increment) 结合使用。例如：

```sql
mysql> CREATE TABLE t1 (a int not null primary key auto_increment);
Query OK, 0 rows affected (0.10 sec)

mysql> set auto_increment_offset=1;
Query OK, 0 rows affected (0.00 sec)

mysql> set auto_increment_increment=3;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO t1 VALUES (),(),(),();
Query OK, 4 rows affected (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM t1;
+----+
| a  |
+----+
|  1 |
|  4 |
|  7 |
| 10 |
+----+
4 rows in set (0.00 sec)
```

### autocommit

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 布尔值
- 默认值: `ON`
- 控制语句在没有显式事务时是否应自动提交。有关更多信息，请参见 [事务概述](/transaction-overview.md#autocommit)。

### block_encryption_mode

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 类型: 枚举
- 默认值: `aes-128-ecb`
- 值选项: `aes-128-ecb`, `aes-192-ecb`, `aes-256-ecb`, `aes-128-cbc`, `aes-192-cbc`, `aes-256-cbc`, `aes-128-ofb`, `aes-192-ofb`, `aes-256-ofb`, `aes-128-cfb`, `aes-192-cfb`, `aes-256-cfb`
- 此变量设置内置函数 [`AES_ENCRYPT()`](/functions-and-operators/encryption-and-compression-functions.md#aes_encrypt) 和 [`AES_DECRYPT()`](/functions-and-operators/encryption-and-compression-functions.md#aes_decrypt) 的加密模式。

### character_set_client

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 默认值: `utf8mb4`
- 从客户端发送的数据的字符集。有关在 TiDB 中使用字符集和排序规则的详细信息，请参见 [字符集和排序规则](/character-set-and-collation.md)。建议使用 [`SET NAMES`](/sql-statements/sql-statement-set-names.md) 在需要时更改字符集。

### character_set_connection

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 默认值: `utf8mb4`
- 没有指定字符集的字符串文字的字符集。

### character_set_database

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 默认值: `utf8mb4`
- 此变量指示正在使用的默认数据库的字符集。**不建议设置此变量**。当选择新的默认数据库时，服务器会更改变量值。

### character_set_results

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 默认值: `utf8mb4`
- 将数据发送到客户端时使用的字符集。

### character_set_server

- 作用域: SESSION | GLOBAL
- 是否持久化到集群: 是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 否
- 默认值: `utf8mb4`