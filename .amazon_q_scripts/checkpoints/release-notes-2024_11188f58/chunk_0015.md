## 2024年7月23日

**常规变更**

- [数据服务（beta）](https://tidbcloud.com/project/data-service) 支持自动生成向量搜索端点。

    如果您的表包含[向量数据类型](/tidb-cloud/vector-search-data-types.md)，您可以自动生成一个向量搜索端点，该端点会根据您选择的距离函数计算向量距离。

    此功能实现了与 AI 平台（例如 [Dify](https://docs.dify.ai/guides/tools) 和 [GPTs](https://openai.com/blog/introducing-gpts)）的无缝集成，通过先进的自然语言处理和 AI 功能增强您的应用程序，从而实现更复杂的任务和智能解决方案。

    有关更多信息，请参阅[自动生成端点](/tidb-cloud/data-service-manage-endpoint.md#generate-an-endpoint-automatically)和[将数据应用与第三方工具集成](/tidb-cloud/data-service-integrations.md)。

- 引入预算功能，帮助您跟踪 TiDB Cloud 的实际成本与计划支出，防止意外成本。

    要访问此功能，您必须是您组织的 `Organization Owner` 或 `Organization Billing Admin` 角色。

    有关更多信息，请参阅[管理 TiDB Cloud 的预算](/tidb-cloud/tidb-cloud-budget.md)。