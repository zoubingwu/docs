## 2022年11月22日

**常规变更**

* 支持直接将数据从 Amazon Aurora MySQL、Amazon Relational Database Service (RDS) MySQL 或自托管的 MySQL 兼容数据库在线迁移到 TiDB Cloud（beta 版）。

    以前，您需要暂停业务并离线导入数据，或者使用第三方工具将数据迁移到 TiDB Cloud，这很复杂。现在，借助 **数据迁移** 功能，您只需在 TiDB Cloud 控制台上执行操作，即可安全地将数据迁移到 TiDB Cloud，且停机时间最短。

    此外，数据迁移还提供完整和增量数据迁移功能，可将现有数据和正在进行的更改从数据源迁移到 TiDB Cloud。

    目前，数据迁移功能仍处于 **beta 版**。它仅适用于 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群，且仅在 AWS 俄勒冈 (us-west-2) 和 AWS 新加坡 (ap-southeast-1) 区域提供。每个组织可以免费创建一个迁移作业。要为一个组织创建多个迁移作业，您需要[提交工单](/tidb-cloud/tidb-cloud-support.md)。

    有关详细信息，请参阅[使用数据迁移将 MySQL 兼容数据库迁移到 TiDB Cloud](/tidb-cloud/migrate-from-mysql-using-data-migration.md)。