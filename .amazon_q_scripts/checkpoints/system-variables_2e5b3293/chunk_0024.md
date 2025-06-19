- 此变量用于指定自动 `ANALYZE` 任务的最大执行时间。当自动 `ANALYZE` 任务的执行时间超过指定时间时，该任务将被终止。当此变量的值为 `0` 时，自动 `ANALYZE` 任务的最大执行时间没有限制。

### tidb_max_bytes_before_tiflash_external_group_by <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否支持 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`-1`
- 取值范围：`[-1, 9223372036854775807]`
- 此变量用于指定 TiFlash 中带有 `GROUP BY` 的 Hash Aggregation 算子的最大内存使用量，以字节为单位。当内存使用量超过指定值时，TiFlash 会触发 Hash Aggregation 算子溢写到磁盘。当此变量的值为 `-1` 时，TiDB 不会将此变量传递给 TiFlash。只有当此变量的值大于等于 `0` 时，TiDB 才会将此变量传递给 TiFlash。当此变量的值为 `0` 时，表示内存使用量不受限制，即 TiFlash Hash Aggregation 算子不会触发溢写。详情请参考 [TiFlash 溢写到磁盘](/tiflash/tiflash-spill-disk.md)。

<CustomContent platform="tidb">

> **注意：**
>
> - 如果 TiDB 集群有多个 TiFlash 节点，聚合通常在多个 TiFlash 节点上分布式执行。此变量控制单个 TiFlash 节点上聚合算子的最大内存使用量。
> - 当此变量设置为 `-1` 时，TiFlash 会根据其自身配置项 [`max_bytes_before_external_group_by`](/tiflash/tiflash-configuration.md#tiflash-configuration-parameters) 的值来确定聚合算子的最大内存使用量。

</CustomContent>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> - 如果 TiDB 集群有多个 TiFlash 节点，聚合通常在多个 TiFlash 节点上分布式执行。此变量控制单个 TiFlash 节点上聚合算子的最大内存使用量。
> - 当此变量设置为 `-1` 时，TiFlash 会根据其自身配置项 `max_bytes_before_external_group_by` 的值来确定聚合算子的最大内存使用量。

</CustomContent>

### tidb_max_bytes_before_tiflash_external_join <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否支持 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`-1`
- 取值范围：`[-1, 9223372036854775807]`
- 此变量用于指定 TiFlash 中带有 `JOIN` 的 Hash Join 算子的最大内存使用量，以字节为单位。当内存使用量超过指定值时，TiFlash 会触发 Hash Join 算子溢写到磁盘。当此变量的值为 `-1` 时，TiDB 不会将此变量传递给 TiFlash。只有当此变量的值大于等于 `0` 时，TiDB 才会将此变量传递给 TiFlash。当此变量的值为 `0` 时，表示内存使用量不受限制，即 TiFlash Hash Join 算子不会触发溢写。详情请参考 [TiFlash 溢写到磁盘](/tiflash/tiflash-spill-disk.md)。

<CustomContent platform="tidb">

> **注意：**
>
> - 如果 TiDB 集群有多个 TiFlash 节点，Join 通常在多个 TiFlash 节点上分布式执行。此变量控制单个 TiFlash 节点上 Join 算子的最大内存使用量。
> - 当此变量设置为 `-1` 时，TiFlash 会根据其自身配置项 [`max_bytes_before_external_join`](/tiflash/tiflash-configuration.md#tiflash-configuration-parameters) 的值来确定 Join 算子的最大内存使用量。

</CustomContent>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> - 如果 TiDB 集群有多个 TiFlash 节点，Join 通常在多个 TiFlash 节点上分布式执行。此变量控制单个 TiFlash 节点上 Join 算子的最大内存使用量。
> - 当此变量设置为 `-1` 时，TiFlash 会根据其自身配置项 `max_bytes_before_external_join` 的值来确定 Join 算子的最大内存使用量。

</CustomContent>

### tidb_max_bytes_before_tiflash_external_sort <span class="version-mark">v7.0.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否支持 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`-1`
- 取值范围：`[-1, 9223372036854775807]`
- 此变量用于指定 TiFlash 中 TopN 和 Sort 算子的最大内存使用量，以字节为单位。当内存使用量超过指定值时，TiFlash 会触发 TopN 和 Sort 算子溢写到磁盘。当此变量的值为 `-1` 时，TiDB 不会将此变量传递给 TiFlash。只有当此变量的值大于等于 `0` 时，TiDB 才会将此变量传递给 TiFlash。当此变量的值为 `0` 时，表示内存使用量不受限制，即 TiFlash TopN 和 Sort 算子不会触发溢写。详情请参考 [TiFlash 溢写到磁盘](/tiflash/tiflash-spill-disk.md)。

<CustomContent platform="tidb">

> **注意：**
>
> - 如果 TiDB 集群有多个 TiFlash 节点，TopN 和 Sort 通常在多个 TiFlash 节点上分布式执行。此变量控制单个 TiFlash 节点上 TopN 和 Sort 算子的最大内存使用量。
> - 当此变量设置为 `-1` 时，TiFlash 会根据其自身配置项 [`max_bytes_before_external_sort`](/tiflash/tiflash-configuration.md#tiflash-configuration-parameters) 的值来确定 TopN 和 Sort 算子的最大内存使用量。

</CustomContent>

<CustomContent platform="tidb-cloud">

> **注意：**
>
> - 如果 TiDB 集群有多个 TiFlash 节点，TopN 和 Sort 通常在多个 TiFlash 节点上分布式执行。此变量控制单个 TiFlash 节点上 TopN 和 Sort 算子的最大内存使用量。
> - 当此变量设置为 `-1` 时，TiFlash 会根据其自身配置项 `max_bytes_before_external_sort` 的值来确定 TopN 和 Sort 算子的最大内存使用量。

</CustomContent>

### tidb_max_chunk_size

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否支持 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1024`
- 取值范围：`[32, 2147483647]`
- 单位：行
- 此变量用于设置执行过程中一个 Chunk 的最大行数。设置过大的值可能会导致缓存局部性问题。建议此变量的值不大于 65536。一个 Chunk 的行数直接影响单个查询所需的内存量。您可以粗略地估计单个 Chunk 所需的内存，方法是考虑查询中所有列的总宽度和 Chunk 的行数。结合执行器的并发性，您可以粗略估计单个查询所需的总内存。建议单个 Chunk 的总内存不超过 16 MiB。当查询涉及大量数据且单个 Chunk 不足以处理所有数据时，TiDB 会多次处理，每次处理迭代都会使 Chunk 大小加倍，从 [`tidb_init_chunk_size`](#tidb_init_chunk_size) 开始，直到 Chunk 大小达到 `tidb_max_chunk_size` 的值。

### tidb_max_delta_schema_count <span class="version-mark">v2.1.18 和 v3.0.5 新增</span>

- 作用域：GLOBAL
- 是否持久化到集群：是
- 是否支持 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`1024`
- 取值范围：`[100, 16384]`