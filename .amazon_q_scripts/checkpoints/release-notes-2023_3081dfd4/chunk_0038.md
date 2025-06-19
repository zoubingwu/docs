## 2023年3月29日

**常规变更**

- [数据服务 (beta)](/tidb-cloud/data-service-overview.md) 支持对数据应用进行更细粒度的访问控制。

    在数据应用详情页面，现在您可以将集群链接到您的数据应用，并为每个 API 密钥指定角色。该角色控制 API 密钥是否可以读取或写入链接集群的数据，并且可以设置为 `ReadOnly` 或 `ReadAndWrite`。此功能为数据应用提供集群级别和权限级别的访问控制，使您可以更灵活地根据业务需求控制访问范围。

    有关更多信息，请参阅 [管理链接的集群](/tidb-cloud/data-service-manage-data-app.md#manage-linked-data-sources) 和 [管理 API 密钥](/tidb-cloud/data-service-api-key.md)。