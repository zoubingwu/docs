## 2023年1月10日

**常规变更**

- 优化了从本地 CSV 文件导入数据到 TiDB 的功能，以改善 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的用户体验。

    - 要上传 CSV 文件，现在您可以简单地将其拖放到 **导入** 页面上的上传区域。
    - 创建导入任务时，如果目标数据库或表不存在，您可以输入一个名称，让 TiDB Cloud 自动为您创建。 对于要创建的目标表，您可以指定主键或选择多个字段以形成复合主键。
    - 导入完成后，您可以通过单击 **通过 Chat2Query 探索您的数据** 或单击任务列表中的目标表名，使用 [AI 驱动的 Chat2Query](/tidb-cloud/explore-data-with-chat2query.md) 探索您的数据。

  有关更多信息，请参见 [将本地文件导入到 TiDB Cloud](/tidb-cloud/tidb-cloud-import-local-files.md)。

**控制台变更**

- 为每个集群添加 **获取支持** 选项，以简化请求特定集群支持的过程。

    您可以通过以下任一方式请求集群支持：

    - 在项目的 [**集群**](https://tidbcloud.com/project/clusters) 页面上，单击集群所在行的 **...**，然后选择 **获取支持**。
    - 在集群概览页面上，单击右上角的 **...**，然后选择 **获取支持**。