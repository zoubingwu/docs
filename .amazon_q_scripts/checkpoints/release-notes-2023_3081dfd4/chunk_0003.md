## 2023年11月28日

**常规变更**

- [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 支持从备份恢复 SQL 绑定。

    TiDB Cloud Dedicated 现在默认在从备份恢复时恢复用户帐户和 SQL 绑定。此增强功能适用于 v6.2.0 或更高版本的集群，从而简化了数据恢复过程。SQL 绑定的恢复确保了与查询相关的配置和优化的顺利重新集成，为您提供更全面、更高效的恢复体验。

    有关更多信息，请参阅[备份和恢复 TiDB Cloud Dedicated 数据](/tidb-cloud/backup-and-restore.md)。

**控制台变更**

- [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 支持监控 SQL 语句 RU 成本。

    TiDB Cloud Serverless 现在提供有关每个 SQL 语句的[请求单元 (RU)](/tidb-cloud/tidb-cloud-glossary.md#request-unit)的详细信息。您可以查看每个 SQL 语句的**总 RU** 和**平均 RU** 成本。此功能可帮助您识别和分析 RU 成本，从而为您的运营提供潜在的成本节省机会。

    要查看您的 SQL 语句 RU 详细信息，请导航到[您的 TiDB Cloud Serverless 集群](https://tidbcloud.com/project/clusters)的**诊断**页面，然后单击 **SQL 语句**选项卡。