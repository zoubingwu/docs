## 2023年2月22日

**常规变更**

- 支持使用 [控制台审计日志](/tidb-cloud/tidb-cloud-console-auditing.md) 功能来跟踪组织成员在 [TiDB Cloud 控制台](https://tidbcloud.com/) 中执行的各种活动。

    控制台审计日志功能仅对具有 `Owner` 或 `Audit Admin` 角色的用户可见，并且默认情况下处于禁用状态。要启用它，请单击 <MDSvgIcon name="icon-top-organization" /> **组织** > **控制台审计日志**，位于 [TiDB Cloud 控制台](https://tidbcloud.com/) 的右上角。

    通过分析控制台审计日志，您可以识别组织内执行的可疑操作，从而提高组织资源和数据的安全性。

    有关更多信息，请参阅 [控制台审计日志](/tidb-cloud/tidb-cloud-console-auditing.md)。

**CLI 变更**

- 为 [TiDB Cloud CLI](/tidb-cloud/cli-reference.md) 添加了一个新命令 `ticloud cluster connect-info`。

    `ticloud cluster connect-info` 是一个允许您获取集群连接字符串的命令。要使用此命令，请[更新 `ticloud`](/tidb-cloud/ticloud-upgrade.md) 到 v0.3.2 或更高版本。