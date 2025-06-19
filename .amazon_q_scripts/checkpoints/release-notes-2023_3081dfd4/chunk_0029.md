## 2023年5月30日

**常规变更**

- 增强了 TiDB Cloud 中数据迁移功能对增量数据迁移的支持。

    现在，您可以指定一个 binlog 位置或全局事务标识符 (GTID)，仅复制指定位置之后生成的增量数据到 TiDB Cloud。此增强功能使您能够更灵活地选择和复制所需的数据，以满足您的特定需求。

    有关详细信息，请参阅[使用数据迁移将 MySQL 兼容数据库中的增量数据迁移到 TiDB Cloud](/tidb-cloud/migrate-incremental-data-from-mysql-using-data-migration.md)。

- 在 [**事件**](/tidb-cloud/tidb-cloud-events.md) 页面添加了一个新的事件类型 (`ImportData`)。

- 从 TiDB Cloud 控制台中移除 **Playground**。

    敬请期待具有优化体验的全新独立 Playground。