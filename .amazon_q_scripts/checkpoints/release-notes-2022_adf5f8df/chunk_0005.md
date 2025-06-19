## 2022年12月13日

**常规变更**

- 推出 TiDB Cloud SQL 编辑器（Beta）用于 Serverless Tier。

    这是一个基于 Web 的 SQL 编辑器，允许您直接编辑和运行针对 Serverless Tier 数据库的 SQL 查询。 您可以在 Serverless Tier 集群的左侧导航栏中轻松找到它。

    对于 Serverless Tier，Web SQL Shell 已被 SQL 编辑器取代。

- 支持使用 [Changefeeds](/tidb-cloud/changefeed-overview.md) 为 Dedicated Tier 流式传输数据。

    - 支持 [将数据变更日志流式传输到 MySQL](/tidb-cloud/changefeed-sink-to-mysql.md)。

      当数据从 MySQL/Aurora 迁移到 TiDB 时，通常需要使用 MySQL 作为备用数据库，以防止出现意外的数据迁移问题。 在这种情况下，您可以使用 MySQL sink 将数据从 TiDB 流式传输到 MySQL。

    - 支持 [将数据变更日志流式传输到 Apache Kafka](/tidb-cloud/changefeed-sink-to-apache-kafka.md) (Beta)。

      将 TiDB 数据流式传输到消息队列是数据集成场景中非常常见的需求。 您可以使用 Kafka sink 来实现与其他数据处理系统（例如 Snowflake）的集成，或者支持业务消费。

    有关更多信息，请参阅 [Changefeed 概述](/tidb-cloud/changefeed-overview.md)。

- 组织所有者可以在**组织设置**中编辑组织的名称。

**控制台变更**

- 优化 [TiDB Cloud 控制台](https://tidbcloud.com) 的导航布局，为用户提供全新的导航体验。

    新布局包括以下更改：

    - 引入左侧导航栏，最大限度地提高屏幕使用效率。
    - 采用更扁平的导航层次结构。

- 改善 Serverless Tier 用户的 [**连接**](/tidb-cloud/connect-to-tidb-cluster-serverless.md) 体验。

    现在，开发人员只需点击几下，即可连接到 SQL 编辑器或使用他们喜欢的工具，而无需切换上下文。