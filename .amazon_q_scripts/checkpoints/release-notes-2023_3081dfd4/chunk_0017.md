## 2023年8月1日

**常规变更**

- 支持 TiDB Cloud 中数据应用的 OpenAPI 规范 [数据服务](https://tidbcloud.com/project/data-service)。

    TiDB Cloud 数据服务为每个数据应用提供自动生成的 OpenAPI 文档。 在文档中，您可以查看端点、参数和响应，并试用这些端点。

    您还可以下载 YAML 或 JSON 格式的数据应用及其已部署端点的 OpenAPI 规范 (OAS)。 OAS 提供标准化的 API 文档、简化的集成和简单的代码生成，从而实现更快的开发和改进的协作。

    有关更多信息，请参阅 [使用 OpenAPI 规范](/tidb-cloud/data-service-manage-data-app.md#use-the-openapi-specification) 和 [将 OpenAPI 规范与 Next.js 结合使用](/tidb-cloud/data-service-oas-with-nextjs.md)。

- 支持在 [Postman](https://www.postman.com/) 中运行数据应用。

    Postman 集成使您能够将数据应用的端点作为集合导入到您首选的工作区中。 然后，您可以受益于增强的协作和无缝的 API 测试，并支持 Postman Web 和桌面应用程序。

    有关更多信息，请参阅 [在 Postman 中运行数据应用](/tidb-cloud/data-service-postman-integration.md)。

- 为 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群引入新的 **暂停中** 状态，允许以经济高效的方式暂停，在此期间不收取任何费用。

    当您单击 TiDB Cloud Dedicated 集群的**暂停**时，该集群将首先进入**暂停中**状态。 暂停操作完成后，集群状态将转换为**已暂停**。

    只有在集群状态转换为**已暂停**后才能恢复集群，这解决了因快速单击**暂停**和**恢复**而导致的异常恢复问题。

    有关更多信息，请参阅 [暂停或恢复 TiDB Cloud Dedicated 集群](/tidb-cloud/pause-or-resume-tidb-cluster.md)。