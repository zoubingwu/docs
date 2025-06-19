## 2024年6月25日

**通用变更**

- [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 支持向量搜索（beta）。

    向量搜索（beta）功能提供了一种高级搜索解决方案，用于跨各种数据类型（包括文档、图像、音频和视频）执行语义相似性搜索。 此功能使开发人员能够使用熟悉的 MySQL 技能轻松构建具有生成式人工智能 (AI) 功能的可扩展应用程序。 主要功能包括：

    - [向量数据类型](/tidb-cloud/vector-search-data-types.md)、[向量索引](/tidb-cloud/vector-search-index.md) 和 [向量函数和运算符](/tidb-cloud/vector-search-functions-and-operators.md)。
    - 与 [LangChain](/tidb-cloud/vector-search-integrate-with-langchain.md)、[LlamaIndex](/tidb-cloud/vector-search-integrate-with-llamaindex.md) 和 [JinaAI](/tidb-cloud/vector-search-integrate-with-jinaai-embedding.md) 的生态系统集成。
    - Python 的编程语言支持：[SQLAlchemy](/tidb-cloud/vector-search-integrate-with-sqlalchemy.md)、[Peewee](/tidb-cloud/vector-search-integrate-with-peewee.md) 和 [Django ORM](/tidb-cloud/vector-search-integrate-with-django-orm.md)。
    - 示例应用程序和教程：使用 [Python](/tidb-cloud/vector-search-get-started-using-python.md) 或 [SQL](/tidb-cloud/vector-search-get-started-using-sql.md) 对文档执行语义搜索。

  有关更多信息，请参阅 [向量搜索（beta）概述](/tidb-cloud/vector-search-overview.md)。

- [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 现在为组织所有者提供每周电子邮件报告。

    这些报告提供了有关集群性能和活动的见解。 通过接收自动每周更新，您可以随时了解集群的信息，并做出数据驱动的决策来优化集群。

- 发布 Chat2Query API v3 端点并弃用 Chat2Query API v1 端点 `/v1/chat2data`。

    使用 Chat2Query API v3 端点，您可以使用会话启动多轮 Chat2Query。

    有关更多信息，请参阅 [Chat2Query API 入门](/tidb-cloud/use-chat2query-api.md)。

**控制台变更**

- 将 Chat2Query（beta）重命名为 SQL Editor（beta）。

    先前称为 Chat2Query 的界面已重命名为 SQL Editor。 此更改阐明了手动 SQL 编辑和 AI 辅助查询生成之间的区别，从而增强了可用性和您的整体体验。

    - **SQL Editor**：用于在 TiDB Cloud 控制台中手动编写和执行 SQL 查询的默认界面。
    - **Chat2Query**：AI 辅助的文本到查询功能，使您能够使用自然语言与数据库进行交互，以生成、重写和优化 SQL 查询。

  有关更多信息，请参阅 [使用 AI 辅助的 SQL Editor 探索您的数据](/tidb-cloud/explore-data-with-chat2query.md)。