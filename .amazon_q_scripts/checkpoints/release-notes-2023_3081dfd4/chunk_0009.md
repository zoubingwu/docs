## 2023年10月11日

**常规变更**

- 支持 [双区域备份 (beta)](/tidb-cloud/backup-and-restore.md#turn-on-dual-region-backup)，适用于部署在 AWS 上的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群。

    您现在可以在云提供商内的地理区域之间复制备份。此功能提供了一个额外的数据保护层和灾难恢复能力。

    更多信息，请参阅 [备份和恢复 TiDB Cloud Dedicated 数据](/tidb-cloud/backup-and-restore.md)。

- 数据迁移现在支持物理模式和逻辑模式来迁移现有数据。

    在物理模式下，迁移速度可以达到 110 MiB/s。与逻辑模式下的 45 MiB/s 相比，迁移性能得到了显着提高。

    更多信息，请参阅 [迁移现有数据和增量数据](/tidb-cloud/migrate-from-mysql-using-data-migration.md#migrate-existing-data-and-incremental-data)。