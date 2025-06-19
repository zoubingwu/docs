## 2021年11月30日

通用变更：

* 将 TiDB Cloud 的开发者层级升级到 [TiDB v5.3.0](https://docs.pingcap.com/tidb/stable/release-5.3.0)

新功能：

* 支持[为您的 TiDB Cloud 项目添加 VPC CIDR](/tidb-cloud/set-up-vpc-peering-connections.md)

改进：

* 提升开发者层级的监控能力
* 支持将自动备份时间设置为与开发者层级集群的创建时间相同

Bug 修复：

* 修复开发者层级中由于磁盘满导致的 TiKV 崩溃问题
* 修复 HTML 注入漏洞