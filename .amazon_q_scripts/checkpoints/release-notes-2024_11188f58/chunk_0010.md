## 2024年9月24日

**通用变更**

- 为在 AWS 上托管的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群提供新的 [TiFlash vCPU 和 RAM 大小](/tidb-cloud/size-your-cluster.md#tiflash-vcpu-and-ram)：`32 vCPU, 128 GiB`

**CLI 变更**

- 发布 [TiDB Cloud CLI v1.0.0-beta.2](https://github.com/tidbcloud/tidbcloud-cli/releases/tag/v1.0.0-beta.2)。

    TiDB Cloud CLI 提供以下新功能：

    - 支持通过 [`ticloud serverless sql-user`](/tidb-cloud/ticloud-serverless-sql-user-create.md) 管理 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的 SQL 用户。
    - 允许在 [`ticloud serverless create`](/tidb-cloud/ticloud-cluster-create.md) 和 [`ticloud serverless update`](/tidb-cloud/ticloud-serverless-update.md) 中禁用 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的公共端点。
    - 添加 [`ticloud auth whoami`](/tidb-cloud/ticloud-auth-whoami.md) 命令，在使用 OAuth 身份验证时获取有关当前用户的信息。
    - 在 [`ticloud serverless export create`](/tidb-cloud/ticloud-serverless-export-create.md) 中支持 `--sql`、`--where` 和 `--filter` 标志，以灵活地选择源表。
    - 支持将数据导出到 CSV 和 Parquet 文件。
    - 支持使用角色 ARN 作为凭据将数据导出到 Amazon S3，并且还支持导出到 Google Cloud Storage 和 Azure Blob Storage。
    - 支持从 Amazon S3、Google Cloud Storage 和 Azure Blob Storage 导入数据。
    - 支持从分支和特定时间戳创建分支。

  TiDB Cloud CLI 增强了以下功能：

    - 改进调试日志记录。现在它可以记录凭据和 user-agent。
    - 将本地导出文件下载速度从每秒数十 KiB 提高到每秒数十 MiB。

  TiDB Cloud CLI 替换或删除了以下功能：

    - [`ticloud serverless export create`](/tidb-cloud/ticloud-serverless-export-create.md) 中的 `--s3.bucket-uri` 标志被 `--s3.uri` 替换。
    - [`ticloud serverless export create`](/tidb-cloud/ticloud-serverless-export-create.md) 中删除了 `--database` 和 `--table` 标志。相反，您可以使用 `--sql`、`--where` 和 `--filter` 标志。
    - [`ticloud serverless update`](/tidb-cloud/ticloud-serverless-update.md) 无法再更新 annotations 字段。