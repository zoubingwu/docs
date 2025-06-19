## 2024年3月5日

**通用变更**

- 将新 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v7.5.0](https://docs.pingcap.com/tidb/v7.5/release-7.5.0) 升级到 [v7.5.1](https://docs.pingcap.com/tidb/v7.5/release-7.5.1)。

**控制台变更**

- 在 [**账单**](https://tidbcloud.com/org-settings/billing/payments) 页面引入 **成本探索器** 标签，该标签提供了一个直观的界面，用于分析和自定义您组织随时间的成本报告。

    要使用此功能，请导航到您组织的 **账单** 页面，然后单击 **成本探索器** 标签。

    有关更多信息，请参见 [成本探索器](/tidb-cloud/tidb-cloud-billing.md#cost-explorer)。

- [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 为 [节点级资源指标](/tidb-cloud/built-in-monitoring.md#server) 显示 **limit** 标签。

    **limit** 标签显示集群中每个组件的 CPU、内存和存储等资源的最大使用量。此增强功能简化了监控集群资源使用率的过程。

    要访问这些指标限制，请导航到集群的 **监控** 页面，然后查看 **指标** 选项卡下的 **服务器** 类别。

    有关更多信息，请参见 [TiDB Cloud Dedicated 集群的指标](/tidb-cloud/built-in-monitoring.md#server)。