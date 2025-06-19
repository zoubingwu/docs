## 2023年7月26日

**常规变更**

- 在 TiDB Cloud [数据服务](https://tidbcloud.com/project/data-service) 中引入一项强大的功能：自动端点生成。

    开发者现在可以轻松地通过最少的点击和配置来创建 HTTP 端点。 消除重复的样板代码，简化并加速端点创建，并减少潜在的错误。

    有关如何使用此功能的更多信息，请参见 [自动生成端点](/tidb-cloud/data-service-manage-endpoint.md#generate-an-endpoint-automatically)。

- 支持 TiDB Cloud [数据服务](https://tidbcloud.com/project/data-service) 中端点的 `PUT` 和 `DELETE` 请求方法。

    - 使用 `PUT` 方法更新或修改数据，类似于 `UPDATE` 语句。
    - 使用 `DELETE` 方法删除数据，类似于 `DELETE` 语句。

  有关更多信息，请参见 [配置属性](/tidb-cloud/data-service-manage-endpoint.md#configure-properties)。

- 支持 TiDB Cloud [数据服务](https://tidbcloud.com/project/data-service) 中 `POST`、`PUT` 和 `DELETE` 请求方法的**批量操作**。

    当为端点启用**批量操作**时，你将能够在单个请求中对多行执行操作。 例如，你可以使用单个 `POST` 请求插入多行数据。

    有关更多信息，请参见 [高级属性](/tidb-cloud/data-service-manage-endpoint.md#advanced-properties)。