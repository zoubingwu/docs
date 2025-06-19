## 2023年5月6日

**常规变更**

- 支持直接访问 TiDB [Serverless 层](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群所在区域的[数据服务终端节点](/tidb-cloud/tidb-cloud-glossary.md#endpoint)。

    对于新创建的 Serverless 层集群，终端节点 URL 现在包含集群区域信息。 通过请求区域域名 `<region>.data.tidbcloud.com`，您可以直接访问 TiDB 集群所在区域的终端节点。

    或者，您也可以请求全局域名 `data.tidbcloud.com` 而不指定区域。 这样，TiDB Cloud 将在内部将请求重定向到目标区域，但这可能会导致额外的延迟。 如果您选择这种方式，请确保在调用终端节点时将 `--location-trusted` 选项添加到您的 curl 命令中。

    有关更多信息，请参阅[调用终端节点](/tidb-cloud/data-service-manage-endpoint.md#call-an-endpoint)。