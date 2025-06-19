## 2024年4月16日

**CLI 变更**

- 推出 [TiDB Cloud CLI 1.0.0-beta.1](https://github.com/tidbcloud/tidbcloud-cli)，构建于新的 [TiDB Cloud API](/tidb-cloud/api-overview.md) 之上。 新的 CLI 带来了以下新功能：

    - [从 TiDB Cloud Serverless 集群导出数据](/tidb-cloud/serverless-export.md)
    - [将本地存储中的数据导入到 TiDB Cloud Serverless 集群](/tidb-cloud/ticloud-import-start.md)
    - [通过 OAuth 认证](/tidb-cloud/ticloud-auth-login.md)
    - [通过 TiDB Bot 提问](/tidb-cloud/ticloud-ai.md)

  在升级您的 TiDB Cloud CLI 之前，请注意这个新的 CLI 与之前的版本不兼容。 例如，CLI 命令中的 `ticloud cluster` 现在更新为 `ticloud serverless`。 更多信息，请参阅 [TiDB Cloud CLI 参考](/tidb-cloud/cli-reference.md)。