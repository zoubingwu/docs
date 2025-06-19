## 2024年11月26日

**通用变更**

- 将新 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v7.5.4](https://docs.pingcap.com/tidb/v7.5/release-7.5.4) 升级到 [v8.1.1](https://docs.pingcap.com/tidb/stable/release-8.1.1)。

- [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 将以下场景下的大数据写入成本降低高达 80%:

    - 当你在 [自动提交模式](/transaction-overview.md#autocommit) 下执行大于 16 MiB 的写入操作时。
    - 当你在 [乐观事务模型](/optimistic-transaction.md) 下执行大于 16 MiB 的写入操作时。
    - 当你 [将数据导入到 TiDB Cloud](/tidb-cloud/tidb-cloud-migration-overview.md#import-data-from-files-to-tidb-cloud) 时。

  此改进提高了数据操作的效率和成本效益，随着工作负载的扩展，可提供更大的节省。