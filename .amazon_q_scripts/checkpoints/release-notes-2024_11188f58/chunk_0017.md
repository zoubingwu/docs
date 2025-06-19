## 2024年7月2日

**通用变更**

- [数据服务（beta）](https://tidbcloud.com/project/data-service) 提供了一个端点库，其中包含预定义的系统端点，您可以直接将其添加到您的数据应用中，从而减少端点开发的工作量。

    目前，该库仅包含 `/system/query` 端点，您只需在预定义的 `sql` 参数中传递 SQL 语句即可执行任何 SQL 语句。 此端点有助于立即执行 SQL 查询，从而提高灵活性和效率。

    有关更多信息，请参阅 [添加预定义的系统端点](/tidb-cloud/data-service-manage-endpoint.md#add-a-predefined-system-endpoint)。

- 增强慢查询数据存储。

    [TiDB Cloud 控制台](https://tidbcloud.com)上的慢查询访问现在更加稳定，并且不会影响数据库性能。