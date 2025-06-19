## 2022年8月2日

* TiDB 和 TiKV 的 `4 vCPU, 16 GiB` 节点大小现已正式发布 (GA)。

    * 对于每个 `4 vCPU, 16 GiB` TiKV 节点，存储大小在 200 GiB 到 2 TiB 之间。
    * 建议的使用场景：

        * 适用于中小企业的低工作负载生产环境
        * PoC 和暂存环境
        * 开发环境

* 在 [专用层集群](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 的 **诊断** 选项卡中添加 [监控页面](/tidb-cloud/built-in-monitoring.md)。

    监控页面提供了一个系统级的入口，用于整体性能诊断。根据自上而下的性能分析方法，监控页面根据数据库时间分解组织 TiDB 性能指标，并以不同的颜色显示这些指标。通过检查这些颜色，您可以一目了然地识别整个系统的性能瓶颈，从而大大缩短性能诊断时间，简化性能分析和诊断。

* 在 CSV 和 Parquet 源文件的 **数据导入** 页面上添加一个开关，用于启用或禁用 **自定义模式**。

    **自定义模式** 功能默认禁用。当您要将文件名与特定模式匹配的 CSV 或 Parquet 文件导入到单个目标表时，可以启用它。

    有关更多信息，请参阅 [导入 CSV 文件](/tidb-cloud/import-csv-files.md) 和 [导入 Apache Parquet 文件](/tidb-cloud/import-parquet-files.md)。

* 添加 TiDB Cloud 支持计划（基本、标准、企业和高级），以满足客户组织的不同支持需求。有关更多信息，请参阅 [TiDB Cloud 支持](/tidb-cloud/tidb-cloud-support.md)。

* 优化 [集群](https://tidbcloud.com/project/clusters) 页面和集群详细信息页面的 UI：

    * 在 **集群** 页面上添加 **连接** 和 **导入数据** 按钮。
    * 将 **连接** 和 **导入数据** 按钮移动到集群详细信息页面的右上角。