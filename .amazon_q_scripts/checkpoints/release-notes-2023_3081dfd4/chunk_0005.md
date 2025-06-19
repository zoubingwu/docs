## 2023年11月14日

**常规变更**

- 当您从 TiDB Cloud Dedicated 集群恢复数据时，默认行为现在从不恢复用户帐户修改为恢复所有用户帐户。

    更多信息，请参阅 [备份和恢复 TiDB Cloud Dedicated 数据](/tidb-cloud/backup-and-restore.md)。

- 引入 changefeed 的事件过滤器。

    此增强功能使您能够通过 [TiDB Cloud 控制台](https://tidbcloud.com/) 轻松管理 changefeed 的事件过滤器，从而简化了从 changefeed 中排除特定事件的过程，并更好地控制下游数据复制。

    更多信息，请参阅 [Changefeed](/tidb-cloud/changefeed-overview.md#edit-a-changefeed)。