## 2022年10月18日

**常规变更**

* 对于专用层集群，TiKV 或 TiFlash 节点的最小存储大小从 500 GiB 更改为 200 GiB。 这对于工作负载数据量较小的用户来说更具成本效益。

    有关更多详细信息，请参见 [TiKV 节点存储](/tidb-cloud/size-your-cluster.md#tikv-node-storage-size) 和 [TiFlash 节点存储](/tidb-cloud/size-your-cluster.md#tiflash-node-storage)。

* 引入在线合同以自定义 TiDB Cloud 订阅并满足合规性要求。

    [**合同** 选项卡](/tidb-cloud/tidb-cloud-billing.md#contract) 已添加到 TiDB Cloud 控制台的 **账单** 页面。 如果您已与我们的销售人员就合同达成一致，并收到一封电子邮件以在线处理合同，则可以转到 **合同** 选项卡以查看和接受合同。 要了解有关合同的更多信息，请随时[联系我们的销售](https://www.pingcap.com/contact-us/)。

**文档变更**

* 添加 [文档](/tidb-cloud/terraform-tidbcloud-provider-overview.md) 以用于 [TiDB Cloud Terraform Provider](https://registry.terraform.io/providers/tidbcloud/tidbcloud)。

    TiDB Cloud Terraform Provider 是一个插件，允许您使用 [Terraform](https://www.terraform.io/) 来管理 TiDB Cloud 资源，例如集群、备份和恢复。 如果您正在寻找一种简单的方法来自动化资源配置和基础架构工作流程，您可以根据 [文档](/tidb-cloud/terraform-tidbcloud-provider-overview.md) 试用 TiDB Cloud Terraform Provider。