## 2024年12月17日

**常规变更**

- TiDB Cloud Serverless 备份和恢复变更

    - 支持将数据恢复到新集群，提供更大的灵活性，并确保您当前集群的运营不受中断。

    - 优化备份和恢复策略，使其与您的集群计划保持一致。 更多信息，请参见 [备份和恢复 TiDB Cloud Serverless 数据](/tidb-cloud/backup-and-restore-serverless.md#learn-about-the-backup-setting)。

    - 应用以下兼容性策略，以帮助您顺利过渡：

        - 在 2024-12-17T10:00:00Z 之前创建的备份将在所有集群中遵循之前的保留期限。
        - 可扩展集群的备份时间将保留当前配置，而免费集群的备份时间将重置为默认设置。