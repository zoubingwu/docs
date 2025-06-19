- 你也可以在查询中使用优化器提示 `/*+ SET_VAR(TIKV_CLIENT_READ_TIMEOUT=N) */` 来设置 TiDB 向 TiKV 发送 RPC 读取请求的超时时间。如果同时设置了优化器提示和此系统变量，则优化器提示的优先级更高。
- 默认值 `0` 表示使用默认超时时间（通常为 40 秒）。

> **注意：**
>
> - 通常，一个常规查询只需要几毫秒，但偶尔当 TiKV 节点处于不稳定的网络或出现 I/O 抖动时，查询可能需要超过 1 秒甚至 10 秒。在这种情况下，你可以使用优化器提示 `/*+ SET_VAR(TIKV_CLIENT_READ_TIMEOUT=100) */` 为特定查询设置 TiKV RPC 读取请求超时时间为 100 毫秒。这样，即使 TiKV 节点的响应速度很慢，TiDB 也可以快速超时，然后将 RPC 请求重新发送到下一个 TiKV Region Peer 所在的 TiKV 节点。由于两个 TiKV 节点同时出现 I/O 抖动的概率很低，因此查询通常可以在几毫秒到 110 毫秒内完成。
> - 不要为 `tikv_client_read_timeout` 设置太小的值（例如，1 毫秒）。否则，当 TiDB 集群的工作负载很高时，请求可能很容易超时，随后的重试会进一步增加 TiDB 集群的负载。
> - 如果需要为不同类型的查询设置不同的超时值，建议使用优化器提示。

### time_zone

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`SYSTEM`
- 此变量返回当前时区。值可以指定为偏移量，例如 '-8:00'，或者指定为命名时区，例如 'America/Los_Angeles'。
- 值 `SYSTEM` 表示时区应与系统主机相同，可通过 [`system_time_zone`](#system_time_zone) 变量获得。

### timestamp

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Float
- 默认值：`0`
- 范围：`[0, 2147483647]`
- 此变量的非空值表示用作 `CURRENT_TIMESTAMP()`、`NOW()` 和其他函数的时间戳的 UNIX epoch。此变量可能用于数据恢复或复制。

### transaction_isolation

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：枚举
- 默认值：`REPEATABLE-READ`
- 可选值：`READ-UNCOMMITTED`、`READ-COMMITTED`、`REPEATABLE-READ`、`SERIALIZABLE`
- 此变量设置事务隔离级别。TiDB 声明 `REPEATABLE-READ` 是为了与 MySQL 兼容，但实际的隔离级别是快照隔离。有关更多详细信息，请参阅[事务隔离级别](/transaction-isolation-levels.md)。

### tx_isolation

此变量是 `transaction_isolation` 的别名。

### tx_isolation_one_shot

> **注意：**
>
> 此变量在 TiDB 内部使用。不建议你使用它。

在内部，TiDB 解析器将 `SET TRANSACTION ISOLATION LEVEL [READ COMMITTED| REPEATABLE READ | ...]` 语句转换为 `SET @@SESSION.TX_ISOLATION_ONE_SHOT = [READ COMMITTED| REPEATABLE READ | ...]`。

### tx_read_ts

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 在 Stale Read 场景中，此会话变量用于帮助记录 Stable Read 时间戳值。
- 此变量用于 TiDB 的内部操作。**不建议**设置此变量。

### txn_scope

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`global`
- 可选值：`global` 和 `local`
- 此变量用于设置当前会话事务是全局事务还是本地事务。
- 此变量用于 TiDB 的内部操作。**不建议**设置此变量。

### validate_password.check_user_name <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`ON`
- 类型：Boolean
- 此变量是密码复杂度检查中的一个检查项。它检查密码是否与用户名匹配。此变量仅在启用 [`validate_password.enable`](#validate_passwordenable-new-in-v650) 时生效。
- 当此变量生效并设置为 `ON` 时，如果你设置密码，TiDB 会将密码与用户名（不包括主机名）进行比较。如果密码与用户名匹配，则密码将被拒绝。
- 此变量独立于 [`validate_password.policy`](#validate_passwordpolicy-new-in-v650)，不受密码复杂度检查级别的限制。

### validate_password.dictionary <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`""`
- 类型：String
- 此变量是密码复杂度检查中的一个检查项。它检查密码是否与字典匹配。此变量仅在启用 [`validate_password.enable`](#validate_passwordenable-new-in-v650) 且 [`validate_password.policy`](#validate_passwordpolicy-new-in-v650) 设置为 `2` (STRONG) 时生效。
- 此变量是一个不超过 1024 个字符的字符串。它包含一个密码中不能存在的单词列表。每个单词用分号 (`;`) 分隔。
- 默认情况下，此变量设置为空字符串，这意味着不执行字典检查。要执行字典检查，你需要将要匹配的单词包含在字符串中。如果配置了此变量，当你设置密码时，TiDB 会将密码的每个子字符串（长度为 4 到 100 个字符）与字典中的单词进行比较。如果密码的任何子字符串与字典中的单词匹配，则密码将被拒绝。比较不区分大小写。

### validate_password.enable <span class="version-mark">v6.5.0 新增</span>

> **注意：**
>
> 此变量始终为 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 启用。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`OFF`
- 类型：Boolean
- 此变量控制是否执行密码复杂度检查。如果此变量设置为 `ON`，则在设置密码时，TiDB 会执行密码复杂度检查。

### validate_password.length <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`8`
- 范围：对于 TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `[0, 2147483647]`，对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `[8, 2147483647]`
- 此变量是密码复杂度检查中的一个检查项。它检查密码长度是否足够。默认情况下，最小密码长度为 `8`。此变量仅在启用 [`validate_password.enable`](#validate_passwordenable-new-in-v650) 时生效。
- 此变量的值不得小于表达式：`validate_password.number_count + validate_password.special_char_count + (2 * validate_password.mixed_case_count)`。