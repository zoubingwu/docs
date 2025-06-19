## 2023年8月15日

**常规变更**

- [数据服务（beta）](https://tidbcloud.com/project/data-service) 支持对 `GET` 请求进行分页，以改善开发体验。

    对于 `GET` 请求，您可以通过在**高级属性**中启用**分页**，并在调用端点时将 `page` 和 `page_size` 指定为查询参数来对结果进行分页。 例如，要获取每页 10 个项目的第二页，您可以使用以下命令：

    ```bash
    curl --digest --user '<Public Key>:<Private Key>' \
      --request GET 'https://<region>.data.tidbcloud.com/api/v1beta/app/<App ID>/endpoint/<Endpoint Path>?page=2&page_size=10'
    ```

    请注意，此功能仅适用于最后一个查询是 `SELECT` 语句的 `GET` 请求。

    有关更多信息，请参见 [调用端点](/tidb-cloud/data-service-manage-endpoint.md#call-an-endpoint)。

- [数据服务（beta）](https://tidbcloud.com/project/data-service) 支持缓存 `GET` 请求的端点响应，并指定生存时间 (TTL)。

    此功能可降低数据库负载并优化端点延迟。

    对于使用 `GET` 请求方法的端点，您可以启用**缓存响应**并在**高级属性**中配置缓存的 TTL 期限。

    有关更多信息，请参见 [高级属性](/tidb-cloud/data-service-manage-endpoint.md#advanced-properties)。

- 禁用为在 AWS 上托管并在 2023 年 8 月 15 日之后创建的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群进行的负载均衡改进，包括：

    - 当您横向扩展在 AWS 上托管的 TiDB 节点时，禁用自动将现有连接迁移到新的 TiDB 节点。
    - 当您横向缩减在 AWS 上托管的 TiDB 节点时，禁用自动将现有连接迁移到可用的 TiDB 节点。

  此更改避免了混合部署的资源争用，并且不会影响已启用此改进的现有集群。 如果您想为新集群启用负载均衡改进，请联系 [TiDB Cloud 支持](/tidb-cloud/tidb-cloud-support.md)。