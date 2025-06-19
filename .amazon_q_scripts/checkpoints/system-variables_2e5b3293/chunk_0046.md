- 如果你修改了 `validate_password.number_count`、`validate_password.special_char_count` 或 `validate_password.mixed_case_count` 的值，使得表达式的值大于 `validate_password.length`，那么 `validate_password.length` 的值会自动更改以匹配表达式的值。

### validate_password.mixed_case_count <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1`
- 范围：TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `[0, 2147483647]`，[TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `[1, 2147483647]`
- 此变量是密码复杂度检查中的一个检查项。它检查密码是否包含足够的大写和小写字母。此变量仅在启用 [`validate_password.enable`](#validate_passwordenable-new-in-v650) 且 [`validate_password.policy`](#validate_passwordpolicy-new-in-v650) 设置为 `1` (MEDIUM) 或更大时生效。
- 密码中的大写字母数量和小写字母数量都不能少于 `validate_password.mixed_case_count` 的值。例如，当该变量设置为 `1` 时，密码必须至少包含一个大写字母和一个小写字母。

### validate_password.number_count <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1`
- 范围：TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `[0, 2147483647]`，[TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `[1, 2147483647]`
- 此变量是密码复杂度检查中的一个检查项。它检查密码是否包含足够的数字。此变量仅在启用 [`validate_password.enable`](#password_reuse_interval-new-in-v650) 且 [`validate_password.policy`](#validate_passwordpolicy-new-in-v650) 设置为 `1` (MEDIUM) 或更大时生效。

### validate_password.policy <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`1`
- 可选值：TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `0`、`1` 和 `2`；[TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `1` 和 `2`
- 此变量控制密码复杂度检查的策略。此变量仅在启用 [`validate_password.enable`](#password_reuse_interval-new-in-v650) 时生效。此变量的值决定了除了 `validate_password.check_user_name` 之外，其他 `validate-password` 变量是否在密码复杂度检查中生效。
- 此变量的值可以是 `0`、`1` 或 `2`（分别对应于 LOW、MEDIUM 或 STRONG）。不同的策略级别有不同的检查：
    - 0 或 LOW：密码长度。
    - 1 或 MEDIUM：密码长度、大写和小写字母、数字和特殊字符。
    - 2 或 STRONG：密码长度、大写和小写字母、数字、特殊字符和字典匹配。

### validate_password.special_char_count <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1`
- 范围：TiDB Self-Managed 和 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 为 `[0, 2147483647]`，[TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 为 `[1, 2147483647]`
- 此变量是密码复杂度检查中的一个检查项。它检查密码是否包含足够的特殊字符。此变量仅在启用 [`validate_password.enable`](#password_reuse_interval-new-in-v650) 且 [`validate_password.policy`](#validate_passwordpolicy-new-in-v650) 设置为 `1` (MEDIUM) 或更大时生效。

### version

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`8.0.11-TiDB-`(tidb 版本)
- 此变量返回 MySQL 版本，后跟 TiDB 版本。例如 '8.0.11-TiDB-v8.1.2'。

### version_comment

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：(string)
- 此变量返回有关 TiDB 版本的其他详细信息。例如，'TiDB Server (Apache License 2.0) Community Edition, MySQL 8.0 compatible'。

### version_compile_machine

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：(string)
- 此变量返回 TiDB 运行所在的 CPU 架构的名称。

### version_compile_os

- 作用域：NONE
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：(string)
- 此变量返回 TiDB 运行所在的 OS 的名称。

### wait_timeout

> **注意：**
>
> 此变量对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 是只读的。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`28800`
- 范围：`[0, 31536000]`
- 单位：秒
- 此变量控制用户会话的空闲超时。零值表示无限制。

### warning_count

- 作用域：SESSION
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：`0`
- 此只读变量指示先前执行的语句中发生的警告数量。

### windowing_use_high_precision

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`
- 此变量控制在计算 [窗口函数](/functions-and-operators/window-functions.md) 时是否使用高精度模式。