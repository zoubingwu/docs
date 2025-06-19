- 性能影响：根据您的业务需求设置合理的大小。不正确的设置会影响性能。如果该值设置得太小，例如 `1`，会导致每个 Block 进行一次网络传输。如果该值设置得太大，例如表的总行数，会导致接收端花费大部分时间等待数据，流水线计算无法工作。要设置合适的值，您可以观察 TiFlash 接收器接收到的行数分布。如果大多数线程只接收到少量行，例如几百行，您可以增加此值以减少网络开销。

### tiflash_fine_grained_shuffle_stream_count <span class="version-mark">v6.2.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：是
- 类型：Integer
- 默认值：`0`
- 范围：`[-1, 1024]`
- 当窗口函数下推到 TiFlash 执行时，可以使用此变量来控制窗口函数执行的并发级别。可能的值如下：

    * -1：禁用 Fine Grained Shuffle 功能。下推到 TiFlash 的窗口函数在单线程中执行。
    * 0：启用 Fine Grained Shuffle 功能。如果 [`tidb_max_tiflash_threads`](/system-variables.md#tidb_max_tiflash_threads-new-in-v610) 设置为有效值（大于 0），则 `tiflash_fine_grained_shuffle_stream_count` 设置为 [`tidb_max_tiflash_threads`](/system-variables.md#tidb_max_tiflash_threads-new-in-v610) 的值。否则，它会根据 TiFlash 计算节点的 CPU 资源自动估算。TiFlash 上窗口函数的实际并发级别为：min(`tiflash_fine_grained_shuffle_stream_count`，TiFlash 节点上的物理线程数)。
    * 大于 0 的整数：启用 Fine Grained Shuffle 功能。下推到 TiFlash 的窗口函数在多个线程中执行。并发级别为：min(`tiflash_fine_grained_shuffle_stream_count`，TiFlash 节点上的物理线程数)。
- 理论上，窗口函数的性能会随着此值的增加而线性增长。但是，如果该值超过实际的物理线程数，反而会导致性能下降。

### tiflash_mem_quota_query_per_node <span class="version-mark">v7.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[-1, 9223372036854775807]`
- 此变量限制了 TiFlash 节点上查询的最大内存使用量。当查询的内存使用量超过此限制时，TiFlash 会返回错误并终止查询。将此变量设置为 `-1` 或 `0` 表示没有限制。当此变量设置为大于 `0` 的值，并且 [`tiflash_query_spill_ratio`](/system-variables.md#tiflash_query_spill_ratio-new-in-v740) 设置为有效值时，TiFlash 会启用 [查询级别的溢写](/tiflash/tiflash-spill-disk.md#query-level-spilling)。

### tiflash_query_spill_ratio <span class="version-mark">v7.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Float
- 默认值：`0.7`
- 范围：`[0, 0.85]`
- 此变量控制 TiFlash [查询级别溢写](/tiflash/tiflash-spill-disk.md#query-level-spilling) 的阈值。`0` 表示禁用自动查询级别溢写。当此变量大于 `0` 且查询的内存使用量超过 [`tiflash_mem_quota_query_per_node`](/system-variables.md#tiflash_mem_quota_query_per_node-new-in-v740) * `tiflash_query_spill_ratio` 时，TiFlash 会触发查询级别的溢写，根据需要溢写查询中支持的算子的数据。

> **注意：**
>
> - 此变量仅在 [`tiflash_mem_quota_query_per_node`](/system-variables.md#tiflash_mem_quota_query_per_node-new-in-v740) 大于 `0` 时生效。换句话说，如果 [tiflash_mem_quota_query_per_node](/system-variables.md#tiflash_mem_quota_query_per_node-new-in-v740) 为 `0` 或 `-1`，即使 `tiflash_query_spill_ratio` 大于 `0`，也不会启用查询级别的溢写。
> - 启用 TiFlash 查询级别溢写后，各个 TiFlash 算子的溢写阈值会自动失效。换句话说，如果 [`tiflash_mem_quota_query_per_node`](/system-variables.md#tiflash_mem_quota_query_per_node-new-in-v740) 和 `tiflash_query_spill_ratio` 都大于 0，则三个变量 [tidb_max_bytes_before_tiflash_external_sort](/system-variables.md#tidb_max_bytes_before_tiflash_external_sort-new-in-v700)、[tidb_max_bytes_before_tiflash_external_group_by](/system-variables.md#tidb_max_bytes_before_tiflash_external_group_by-new-in-v700) 和 [tidb_max_bytes_before_tiflash_external_join](/system-variables.md#tidb_max_bytes_before_tiflash_external_join-new-in-v700) 会自动失效，相当于将它们设置为 `0`。

### tiflash_replica_read <span class="version-mark">v7.3.0 新增</span>

> **注意：**
>
> 此 TiDB 变量不适用于 TiDB Cloud。

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Enumeration
- 默认值：`all_replicas`
- 可选值：`all_replicas`、`closest_adaptive` 或 `closest_replicas`
- 此变量用于设置查询需要 TiFlash 引擎时选择 TiFlash 副本的策略。
    - `all_replicas` 表示使用所有可用的 TiFlash 副本进行分析计算。
    - `closest_adaptive` 表示优先使用与发起查询的 TiDB 节点位于同一区域的 TiFlash 副本。如果此区域中的副本不包含所有必需的数据，则查询将涉及来自其他区域的 TiFlash 副本及其相应的 TiFlash 节点。
    - `closest_replicas` 表示仅使用与发起查询的 TiDB 节点位于同一区域的 TiFlash 副本。如果此区域中的副本不包含所有必需的数据，则查询将返回错误。

<CustomContent platform="tidb">

> **注意：**
>
> - 如果 TiDB 节点未配置 [区域属性](/schedule-replicas-by-topology-labels.md#optional-configure-labels-for-tidb) 且 `tiflash_replica_read` 未设置为 `all_replicas`，则 TiFlash 将忽略副本选择策略。相反，它将使用所有 TiFlash 副本进行查询并返回 `The variable tiflash_replica_read is ignored.` 警告。
> - 如果 TiFlash 节点未配置 [区域属性](/schedule-replicas-by-topology-labels.md#configure-labels-for-tikv-and-tiflash)，则它们被视为不属于任何区域的节点。

</CustomContent>

### tikv_client_read_timeout <span class="version-mark">v7.4.0 新增</span>

- 作用域：SESSION | GLOBAL
- 是否持久化到集群：是
- 是否适用于 Hint [SET_VAR](/optimizer-hints.md#set_varvar_namevar_value)：否
- 类型：Integer
- 默认值：`0`
- 范围：`[0, 2147483647]`
- 单位：毫秒
- 您可以使用 `tikv_client_read_timeout` 设置 TiDB 在查询中发送 TiKV RPC 读取请求的超时时间。当 TiDB 集群处于网络不稳定或 TiKV I/O 延迟抖动严重的环境中，并且您的应用程序对 SQL 查询的延迟敏感时，您可以设置 `tikv_client_read_timeout` 以减少 TiKV RPC 读取请求的超时时间。在这种情况下，当 TiKV 节点出现 I/O 延迟抖动时，TiDB 可以快速超时并将 RPC 请求重新发送到下一个 TiKV Region Peer 所在的 TiKV 节点。如果所有 TiKV Region Peer 的请求都超时，TiDB 将使用默认超时时间（通常为 40 秒）重试。