## 2023年9月5日

**常规变更**

- [数据服务 (beta)](https://tidbcloud.com/project/data-service) 支持为每个 API 密钥自定义速率限制，以满足不同情况下的特定速率限制要求。

    您可以在[创建](/tidb-cloud/data-service-api-key.md#create-an-api-key)或[编辑](/tidb-cloud/data-service-api-key.md#edit-an-api-key)密钥时调整 API 密钥的速率限制。

    有关更多信息，请参见[速率限制](/tidb-cloud/data-service-api-key.md#rate-limiting)。

- 支持 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的新 AWS 区域：圣保罗 (sa-east-1)。

- 支持为每个 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 IP 访问列表添加最多 100 个 IP 地址。

    有关更多信息，请参见[配置 IP 访问列表](/tidb-cloud/configure-ip-access-list.md)。

**控制台变更**

- 为 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群引入 **Events** 页面，该页面提供集群主要变更的记录。

    在此页面上，您可以查看过去 7 天的事件历史记录，并跟踪重要详细信息，例如触发时间和发起操作的用户。

    有关更多信息，请参见 [TiDB Cloud 集群事件](/tidb-cloud/tidb-cloud-events.md)。

**API 变更**

- 发布多个 TiDB Cloud API 端点，用于管理 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [AWS PrivateLink](https://aws.amazon.com/privatelink/?privatelink-blogs.sort-by=item.additionalFields.createdDate&privatelink-blogs.sort-order=desc) 或 [Google Cloud Private Service Connect](https://cloud.google.com/vpc/docs/private-service-connect)：

    - 为集群创建私有端点服务
    - 检索集群的私有端点服务信息
    - 为集群创建私有端点
    - 列出集群的所有私有端点
    - 列出项目中的所有私有端点
    - 删除集群的私有端点

  有关更多信息，请参阅 [API 文档](https://docs.pingcap.com/tidbcloud/api/v1beta#tag/Cluster)。