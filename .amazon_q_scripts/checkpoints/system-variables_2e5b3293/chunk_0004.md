- \`HIGH_COMPRESSION\`: 高压缩比模式。

### mpp_version <span class="version-mark">v6.6.0 新增</span>

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 默认值：\`UNSPECIFIED\`
- 可选值：\`UNSPECIFIED\`，\`0\`，\`1\`，\`2\`
- 此变量用于指定 MPP 执行计划的不同版本。指定版本后，TiDB 会选择指定版本的 MPP 执行计划。变量值的含义如下：
    - \`UNSPECIFIED\`: 表示未指定。TiDB 自动选择最新版本 \`2\`。
    - \`0\`: 兼容所有 TiDB 集群版本。MPP 版本大于 \`0\` 的功能在此模式下不生效。
    - \`1\`: v6.6.0 新增，用于启用 TiFlash 上带压缩的数据交换。有关详细信息，请参阅 [MPP 版本和交换数据压缩](/explain-mpp.md#mpp-version-and-exchange-data-compression)。
    - \`2\`: v7.3.0 新增，用于在 MPP 任务在 TiFlash 上遇到错误时提供更准确的错误消息。

### password_reuse_interval <span class="version-mark">v6.5.0 新增</span>

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：\`0\`
- 范围：\`[0, 4294967295]\`
- 此变量用于建立密码重用策略，允许 TiDB 基于经过的时间限制密码重用。默认值 \`0\` 表示禁用基于经过时间的密码重用策略。当此变量设置为正整数 \`N\` 时，不允许重用过去 \`N\` 天内使用的任何密码。

### max_connections

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：\`0\`
- 范围：\`[0, 100000]\`
- 单个 TiDB 实例允许的最大并发连接数。此变量可用于资源控制。
- 默认值 \`0\` 表示没有限制。当此变量的值大于 \`0\`，并且连接数达到该值时，TiDB 服务器将拒绝来自客户端的新连接。

### max_execution_time

- 作用域：SESSION | GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：\`0\`
- 范围：\`[0, 2147483647]\`
- 单位：毫秒
- 语句的最大执行时间。默认值为无限制（零）。

> **注意：**
>
> 在 v6.4.0 之前，\`max_execution_time\` 系统变量对所有类型的语句生效。从 v6.4.0 开始，此变量仅控制只读语句的最大执行时间。超时值的精度约为 100 毫秒。这意味着语句可能不会在你指定的精确毫秒数内终止。

<CustomContent platform="tidb">

对于带有 \[`MAX_EXECUTION_TIME`](/optimizer-hints.md#max_execution_timen) hint 的 SQL 语句，此语句的最大执行时间受 hint 限制，而不是受此变量限制。该 hint 也可以与 SQL 绑定一起使用，如 [SQL FAQ](/faq/sql-faq.md#how-to-prevent-the-execution-of-a-particular-sql-statement) 中所述。

</CustomContent>

<CustomContent platform="tidb-cloud">

对于带有 \[`MAX_EXECUTION_TIME`](/optimizer-hints.md#max_execution_timen) hint 的 SQL 语句，此语句的最大执行时间受 hint 限制，而不是受此变量限制。该 hint 也可以与 SQL 绑定一起使用，如 [SQL FAQ](https://docs.pingcap.com/tidb/stable/sql-faq) 中所述。

</CustomContent>

### max_prepared_stmt_count

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：\`-1\`
- 范围：\`[-1, 1048576]\`
- 指定当前 TiDB 实例中 \[`PREPARE`](/sql-statements/sql-statement-prepare.md) 语句的最大数量。
- 值 \`-1\` 表示当前 TiDB 实例中 \`PREPARE\` 语句的最大数量没有限制。
- 如果将变量设置为超过上限 \`1048576\` 的值，则使用 \`1048576\` 代替：

```sql
mysql> SET GLOBAL max_prepared_stmt_count = 1048577;
Query OK, 0 rows affected, 1 warning (0.01 sec)

mysql> SHOW WARNINGS;
+---------+------+--------------------------------------------------------------+
| Level   | Code | Message                                                      |
+---------+------+--------------------------------------------------------------+
| Warning | 1292 | Truncated incorrect max_prepared_stmt_count value: '1048577' |
+---------+------+--------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SHOW GLOBAL VARIABLES LIKE 'max_prepared_stmt_count';
+-------------------------+---------+
| Variable_name           | Value   |
+-------------------------+---------+
| max_prepared_stmt_count | 1048576 |
+-------------------------+---------+
1 row in set (0.00 sec)
```

### pd_enable_follower_handle_region <span class="version-mark">v7.6.0 新增</span>

> **警告：**
>
> [Active PD Follower](https://docs.pingcap.com/tidb/dev/tune-region-performance#use-the-active-pd-follower-feature-to-enhance-the-scalability-of-pds-region-information-query-service) 功能是实验性的。不建议在生产环境中使用。此功能可能会更改或删除，恕不另行通知。如果发现错误，可以在 GitHub 上报告 [issue](https://github.com/pingcap/tidb/issues)。

- 作用域：GLOBAL
- 持久化到集群：是
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：\`OFF\`
- 此变量控制是否启用 Active PD Follower 功能（目前仅适用于 Region 信息请求）。当值为 \`OFF\` 时，TiDB 仅从 PD leader 获取 Region 信息。当值为 \`ON\` 时，TiDB 将 Region 信息请求均匀地分配给所有 PD 服务器，PD follower 也可以处理 Region 请求，从而降低 PD leader 的 CPU 压力。
- 启用 Active PD Follower 的场景：
    * 在具有大量 Region 的集群中，由于处理心跳和调度任务的开销增加，PD leader 遇到高 CPU 压力。
    * 在具有许多 TiDB 实例的 TiDB 集群中，由于 Region 信息请求的高并发，PD leader 遇到高 CPU 压力。

### plugin_dir

> **注意：**
>
> [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 不支持此变量。

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 指示要加载插件的目录，由命令行标志指定。

### plugin_load

> **注意：**
>
> [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 不支持此变量。

- 作用域：GLOBAL
- 持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 指示 TiDB 启动时要加载的插件。这些插件由命令行标志指定，并用逗号分隔。

### port

- 作用域：NONE
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：\`4000\`
- 范围：\`[0, 65535]\`
- \`tidb-server\` 在使用 MySQL 协议时监听的端口。

### rand_seed1

- 作用域：SESSION
- 适用于 hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否