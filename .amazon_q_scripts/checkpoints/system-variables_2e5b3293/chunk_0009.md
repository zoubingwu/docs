- 用于处理单事务提交阶段中执行提交相关请求的 Goroutine 数量。
- 如果要提交的事务太大，则提交事务时流控队列的等待时间可能过长。在这种情况下，您可以增加此配置值以加快提交速度。
- 此设置以前是一个 `tidb.toml` 选项 (`performance.committer-concurrency`)，但从 TiDB v6.1.0 开始更改为系统变量。

### tidb_config

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：GLOBAL
- 是否持久化到集群：否，仅适用于您当前连接的 TiDB 实例。
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 默认值：""
- 此变量是只读的。它用于获取当前 TiDB 服务器的配置信息。

### tidb_constraint_check_in_place

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`OFF`
- 此变量仅适用于乐观事务。对于悲观事务，请改用 [`tidb_constraint_check_in_place_pessimistic`](#tidb_constraint_check_in_place_pessimistic-new-in-v630)。
- 当此变量设置为 `OFF` 时，对唯一索引中重复值的检查将延迟到事务提交时。这有助于提高性能，但对于某些应用程序来说可能是一种意想不到的行为。有关详细信息，请参见 [约束](/constraints.md#optimistic-transactions)。

    - 当设置 `tidb_constraint_check_in_place` 为 `OFF` 并使用乐观事务时：

        ```sql
        tidb> create table t (i int key);
        tidb> insert into t values (1);
        tidb> begin optimistic;
        tidb> insert into t values (1);
        Query OK, 1 row affected
        tidb> commit; -- 仅在事务提交时检查。
        ERROR 1062 : Duplicate entry '1' for key 't.PRIMARY'
        ```

    - 当设置 `tidb_constraint_check_in_place` 为 `ON` 并使用乐观事务时：

        ```sql
        tidb> set @@tidb_constraint_check_in_place=ON;
        tidb> begin optimistic;
        tidb> insert into t values (1);
        ERROR 1062 : Duplicate entry '1' for key 't.PRIMARY'
        ```

### tidb_constraint_check_in_place_pessimistic <span class="version-mark">v6.3.0 新增</span>

- 作用域：SESSION
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean

<CustomContent platform="tidb">

- 默认值：默认情况下，[`pessimistic-txn.constraint-check-in-place-pessimistic`](/tidb-configuration-file.md#constraint-check-in-place-pessimistic-new-in-v640) 配置项为 `true`，因此此变量的默认值为 `ON`。当 [`pessimistic-txn.constraint-check-in-place-pessimistic`](/tidb-configuration-file.md#constraint-check-in-place-pessimistic-new-in-v640) 设置为 `false` 时，此变量的默认值为 `OFF`。

</CustomContent>

<CustomContent platform="tidb-cloud">

- 默认值：`ON`

</CustomContent>

- 此变量仅适用于悲观事务。对于乐观事务，请改用 [`tidb_constraint_check_in_place`](#tidb_constraint_check_in_place)。
- 当此变量设置为 `OFF` 时，TiDB 会延迟唯一索引的唯一约束检查（延迟到下次执行需要锁定索引的语句时，或延迟到提交事务时）。这有助于提高性能，但对于某些应用程序来说可能是一种意想不到的行为。有关详细信息，请参见 [约束](/constraints.md#pessimistic-transactions)。
- 禁用此变量可能会导致 TiDB 在悲观事务中返回 `LazyUniquenessCheckFailure` 错误。发生此错误时，TiDB 会回滚当前事务。
- 禁用此变量后，您无法在悲观事务中使用 [`SAVEPOINT`](/sql-statements/sql-statement-savepoint.md)。
- 禁用此变量后，提交悲观事务可能会返回 `Write conflict` 或 `Duplicate entry` 错误。发生此类错误时，TiDB 会回滚当前事务。

    - 当设置 `tidb_constraint_check_in_place_pessimistic` 为 `OFF` 并使用悲观事务时：

        {{< copyable "sql" >}}

        ```sql
        set @@tidb_constraint_check_in_place_pessimistic=OFF;
        create table t (i int key);
        insert into t values (1);
        begin pessimistic;
        insert into t values (1);
        ```

        ```
        Query OK, 1 row affected
        ```

        ```sql
        tidb> commit; -- 仅在事务提交时检查。
        ```

        ```
        ERROR 1062 : Duplicate entry '1' for key 't.PRIMARY'
        ```

    - 当设置 `tidb_constraint_check_in_place_pessimistic` 为 `ON` 并使用悲观事务时：

        ```sql
        set @@tidb_constraint_check_in_place_pessimistic=ON;
        begin pessimistic;
        insert into t values (1);
        ```

        ```
        ERROR 1062 : Duplicate entry '1' for key 't.PRIMARY'
        ```

### tidb_cost_model_version <span class="version-mark">v6.2.0 新增</span>

> **注意：**
>
> - 从 TiDB v6.5.0 开始，新创建的集群默认使用 Cost Model Version 2。如果您从早于 v6.5.0 的 TiDB 版本升级到 v6.5.0 或更高版本，则 `tidb_cost_model_version` 值不会更改。
> - 切换成本模型版本可能会导致查询计划发生变化。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`2`
- 可选值：
    - `1`：启用 Cost Model Version 1，这是 TiDB v6.4.0 及更早版本中默认使用的。
    - `2`：启用 [Cost Model Version 2](/cost-model.md#cost-model-version-2)，该版本在 TiDB v6.5.0 中正式发布，并且在内部测试中比版本 1 更准确。
- 成本模型的版本会影响优化器的计划决策。有关更多详细信息，请参见 [成本模型](/cost-model.md)。

### tidb_current_ts

- 作用域：SESSION
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 9223372036854775807]`
- 此变量是只读的。它用于获取当前事务的时间戳。

### tidb_ddl_disk_quota <span class="version-mark">v6.3.0 新增</span>

> **注意：**
>
> 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless)，此变量是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`107374182400` (100 GiB)
- 范围：`[107374182400, 1125899906842624]` ([100 GiB, 1 PiB])
- 单位：字节
- 仅当启用 [`tidb_ddl_enable_fast_reorg`](#tidb_ddl_enable_fast_reorg-new-in-v630) 时，此变量才生效。它设置创建索引时回填期间本地存储的使用限制。

### tidb_ddl_enable_fast_reorg <span class="version-mark">v6.3.0 新增</span>

> **注意：**
>
> - 如果您使用的是 [TiDB Cloud Dedicated](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-dedicated) 集群，要使用此变量提高索引创建速度，请确保您的 TiDB 集群托管在 AWS 上，并且您的 TiDB 节点大小至少为 8 vCPU。
> - 对于 [TiDB Cloud Serverless](https://docs.pingcap.com/tidbcloud/select-cluster-tier#tidb-cloud-serverless) 集群，此变量是只读的。

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Boolean
- 默认值：`ON`