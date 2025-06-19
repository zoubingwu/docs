## 2023年3月14日

**常规变更**

- 将新 [专用层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v6.5.0](https://docs.pingcap.com/tidb/v6.5/release-6.5.0) 升级到 [v6.5.1](https://docs.pingcap.com/tidb/v6.5/release-6.5.1)。

- 支持在上传带有标题行的本地 CSV 文件时，修改 TiDB Cloud 创建的目标表的列名。

    当将带有标题行的本地 CSV 文件导入到 [Serverless 层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群时，如果您需要 TiDB Cloud 创建目标表，并且标题行中的列名不符合 TiDB Cloud 列命名约定，您将在相应列名旁边看到一个警告图标。要解决此警告，您可以将光标移到图标上，然后按照消息编辑现有列名或输入新的列名。

    有关列命名约定的信息，请参阅 [导入本地文件](/tidb-cloud/tidb-cloud-import-local-files.md#import-local-files)。