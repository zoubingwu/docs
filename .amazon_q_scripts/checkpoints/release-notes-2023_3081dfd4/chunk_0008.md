## 2023年10月25日

**常规变更**

- [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 支持 Google Cloud 上的双区域备份（beta）。

    托管在 Google Cloud 上的 TiDB Cloud Dedicated 集群可以与 Google Cloud Storage 无缝协作。 与 Google Cloud Storage 的 [双区域](https://cloud.google.com/storage/docs/locations#location-dr) 功能类似，您在 TiDB Cloud Dedicated 中用于双区域的区域对必须位于同一多区域内。 例如，东京和大阪位于同一多区域 `ASIA` 中，因此它们可以一起用于双区域存储。

    有关更多信息，请参阅 [备份和恢复 TiDB Cloud Dedicated 数据](/tidb-cloud/backup-and-restore.md#turn-on-dual-region-backup)。

- [将数据变更日志流式传输到 Apache Kafka](/tidb-cloud/changefeed-sink-to-apache-kafka.md) 的功能现已正式发布 (GA)。

    经过 10 个月的成功 Beta 试用后，将数据变更日志从 TiDB Cloud 流式传输到 Apache Kafka 的功能已正式发布。 将数据从 TiDB 流式传输到消息队列是数据集成场景中的常见需求。 您可以使用 Kafka sink 与其他数据处理系统（例如 Snowflake）集成或支持业务消费。

    有关更多信息，请参阅 [Changefeed 概述](/tidb-cloud/changefeed-overview.md)。