</CustomContent>

<CustomContent platform="tidb-cloud">

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 字符串
- 默认值: `""`
- 此变量用于控制优化器的一些内部行为。
- 优化器的行为可能因用户场景或 SQL 语句而异。此变量提供了对优化器更细粒度的控制，并有助于防止升级后由于优化器行为更改而导致的性能下降。
- 有关更详细的介绍，请参阅 [优化器修复控制](/optimizer-fix-controls.md)。

</CustomContent>

### tidb_opt_force_inline_cte <span class="version-mark">v6.3.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 布尔值
- 默认值: `OFF`
- 此变量用于控制是否内联整个会话中的公共表表达式 (CTE)。默认值为 `OFF`，表示默认情况下不强制内联 CTE。但是，您仍然可以通过指定 `MERGE()` hint 来内联 CTE。如果变量设置为 `ON`，则此会话中的所有 CTE（递归 CTE 除外）都将被强制内联。

### tidb_opt_advanced_join_hint <span class="version-mark">v7.0.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 布尔值
- 默认值: `ON`
- 此变量用于控制 Join Method hint（例如 [`HASH_JOIN()` hint](/optimizer-hints.md#hash_joint1_name--tl_name-) 和 [`MERGE_JOIN()` hint](/optimizer-hints.md#merge_joint1_name--tl_name-)）是否影响 Join Reorder 优化过程，包括 [`LEADING()` hint](/optimizer-hints.md#leadingt1_name--tl_name-) 的使用。默认值为 `ON`，表示不影响。如果设置为 `OFF`，则在同时使用 Join Method hint 和 `LEADING()` hint 的某些场景中可能会发生冲突。

> **注意：**
>
> v7.0.0 之前的版本的行为与将此变量设置为 `OFF` 的行为一致。为了确保向前兼容性，当您从早期版本升级到 v7.0.0 或更高版本的集群时，此变量设置为 `OFF`。为了获得更灵活的 hint 行为，强烈建议在没有性能下降的情况下将此变量切换为 `ON`。

### tidb_opt_insubq_to_join_and_agg

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 布尔值
- 默认值: `ON`
- 此变量用于设置是否启用将子查询转换为 join 和聚合的优化规则。
- 例如，在启用此优化规则后，子查询将按如下方式转换：

    ```sql
    select * from t where t.a in (select aa from t1);
    ```

    子查询转换为 join 如下：

    ```sql
    select t.* from t, (select aa from t1 group by aa) tmp_t where t.a = tmp_t.aa;
    ```

    如果 `t1` 在 `aa` 列中被限制为 `unique` 和 `not null`。您可以使用以下语句，无需聚合。

    ```sql
    select t.* from t, t1 where t.a=t1.aa;
    ```

### tidb_opt_join_reorder_threshold

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 整数
- 默认值: `0`
- 范围: `[0, 2147483647]`
- 此变量用于控制 TiDB Join Reorder 算法的选择。当参与 Join Reorder 的节点数大于此阈值时，TiDB 选择贪婪算法，当小于此阈值时，TiDB 选择动态规划算法。
- 目前，对于 OLTP 查询，建议保持默认值。对于 OLAP 查询，建议将变量值设置为 10~15，以便在 OLAP 场景中获得更好的连接顺序。

### tidb_opt_limit_push_down_threshold

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 整数
- 默认值: `100`
- 范围: `[0, 2147483647]`
- 此变量用于设置确定是否将 Limit 或 TopN 算子下推到 TiKV 的阈值。
- 如果 Limit 或 TopN 算子的值小于或等于此阈值，则这些算子将被强制下推到 TiKV。此变量解决了 Limit 或 TopN 算子由于错误估计而无法部分下推到 TiKV 的问题。

### tidb_opt_memory_factor

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 浮点数
- 范围: `[0, 2147483647]`
- 默认值: `0.001`
- 表示 TiDB 存储一行数据的内存成本。此变量在 [成本模型](/cost-model.md) 中内部使用，**不**建议修改其值。

### tidb_opt_mpp_outer_join_fixed_build_side <span class="version-mark">v5.1.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 布尔值
- 默认值: `OFF`
- 当变量值为 `ON` 时，左连接算子始终使用内表作为构建端，右连接算子始终使用外表作为构建端。如果将值设置为 `OFF`，则外连接算子可以使用表的任意一侧作为构建端。

### tidb_opt_network_factor

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 浮点数
- 范围: `[0, 2147483647]`
- 默认值: `1.0`
- 表示通过网络传输 1 字节数据的网络成本。此变量在 [成本模型](/cost-model.md) 中内部使用，**不**建议修改其值。

### tidb_opt_objective <span class="version-mark">v7.4.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 枚举
- 默认值: `moderate`
- 可选值: `moderate`, `determinate`
- 此变量控制优化器的目标。`moderate` 保持 TiDB v7.4.0 之前版本的默认行为，其中优化器尝试使用更多信息来生成更好的执行计划。`determinate` 模式倾向于更保守，并使执行计划更稳定。
- 实时统计信息是基于 DML 语句自动更新的总行数和修改的行数。当此变量设置为 `moderate`（默认值）时，TiDB 基于实时统计信息生成执行计划。当此变量设置为 `determinate` 时，TiDB 不使用实时统计信息来生成执行计划，这将使执行计划更稳定。
- 对于长期稳定的 OLTP 工作负载，或者如果用户对现有的执行计划有信心，建议使用 `determinate` 模式以减少意外执行计划更改的可能性。此外，您可以使用 [`LOCK STATS`](/sql-statements/sql-statement-lock-stats.md) 来防止统计信息被修改并进一步稳定执行计划。

### tidb_opt_ordering_index_selectivity_ratio <span class="version-mark">v8.0.0 新增</span>

- 作用域: SESSION | GLOBAL
- 持久化到集群: 是
- 适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value): 是
- 类型: 浮点数
- 默认值: `-1`
- 范围: `[-1, 1]`