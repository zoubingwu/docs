## 2022年10月28日

**常规变更**

* 开发者层级已升级到[无服务器层级](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless)。无服务器层级是 TiDB 的完全托管、自动伸缩部署，现已可用。它仍处于 Beta 阶段，可免费使用。

    * 无服务器层级集群仍然包含与专用层级集群完全相同功能的 HTAP 能力。
    * 无服务器层级为您提供更快的集群创建时间和即时冷启动时间。与开发者层级相比，创建时间从几分钟缩短到几秒钟。
    * 您无需担心部署拓扑。无服务器层级将根据您的请求自动调整。
    * 无服务器层级[为了安全起见，强制执行与集群的 TLS 连接](/tidb-cloud/secure-connections-to-serverless-clusters.md)。
    * 现有的开发者层级集群将在未来几个月内自动迁移到无服务器层级。您使用集群的能力不应受到影响，并且您不会因在 Beta 版中使用无服务器层级集群而被收费。

  从[这里](/tidb-cloud/tidb-cloud-quickstart.md)开始。