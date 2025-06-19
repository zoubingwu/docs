## 2024年11月19日

**常规变更**

- [TiDB Cloud Serverless 分支（beta）](/tidb-cloud/branch-overview.md) 引入了以下分支管理方面的改进：

    - **灵活的分支创建**：创建分支时，您可以选择特定的集群或分支作为父级，并指定要从父级使用的精确时间点。这使您可以精确控制分支中的数据。

    - **分支重置**：您可以重置分支，使其与父级的最新状态同步。

    - **改进的 GitHub 集成**：[TiDB Cloud Branching](https://github.com/apps/tidb-cloud-branching) GitHub App 引入了 [`branch.mode`](/tidb-cloud/branch-github-integration.md#branchmode) 参数，该参数控制拉取请求同步期间的行为。在默认模式 `reset` 下，该应用程序会重置分支以匹配拉取请求中的最新更改。

  有关更多信息，请参阅[管理 TiDB Cloud Serverless 分支](/tidb-cloud/branch-manage.md)和[将 TiDB Cloud Serverless 分支（Beta）与 GitHub 集成](/tidb-cloud/branch-github-integration.md)。