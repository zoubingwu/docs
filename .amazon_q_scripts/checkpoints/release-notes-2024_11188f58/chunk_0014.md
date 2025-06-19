## 2024年8月6日

**通用变更**

- [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 在 AWS 上负载均衡的计费变更。

    从 2024 年 8 月 1 日起，TiDB Cloud Dedicated 的账单将包含新的 AWS 公共 IPv4 地址费用，与 [AWS 自 2024 年 2 月 1 日起生效的定价变更](https://aws.amazon.com/blogs/aws/new-aws-public-ipv4-address-charge-public-ip-insights/)保持一致。 每个公共 IPv4 地址的费用为每小时 0.005 美元，这将导致每个托管在 AWS 上的 TiDB Cloud Dedicated 集群每月大约 10 美元。

    此费用将显示在您[账单详情](/tidb-cloud/tidb-cloud-billing.md#billing-details)中现有的 **TiDB Cloud Dedicated - 数据传输 - 负载均衡** 服务下。

- 将新的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v7.5.2](https://docs.pingcap.com/tidb/v7.5/release-7.5.2) 升级到 [v7.5.3](https://docs.pingcap.com/tidb/v7.5/release-7.5.3)。

**控制台变更**

- 增强 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 的集群大小配置体验。

    优化 [**创建集群**](/tidb-cloud/create-tidb-cluster.md) 和 [**修改集群**](/tidb-cloud/scale-tidb-cluster.md) 页面上 TiDB Cloud Dedicated 集群的 **集群大小** 部分的布局。 此外，**集群大小** 部分现在包含指向节点大小推荐文档的链接，这有助于您选择合适的集群大小。