## 2023年7月18日

**常规变更**

- 优化了组织级别和项目级别的基于角色的访问控制，使您可以向用户授予具有最低权限的角色，从而提高安全性、合规性和生产力。

    - 组织角色包括 `Organization Owner`、`Organization Billing Admin`、`Organization Console Audit Admin` 和 `Organization Member`。
    - 项目角色包括 `Project Owner`、`Project Data Access Read-Write` 和 `Project Data Access Read-Only`。
    - 要管理项目中的集群（例如集群创建、修改和删除），您需要担任 `Organization Owner` 或 `Project Owner` 角色。

  有关不同角色的权限的更多信息，请参阅 [用户角色](/tidb-cloud/manage-user-access.md#user-roles)。

- 支持用于在 AWS 上托管的 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的客户管理的加密密钥 (CMEK) 功能（beta）。

    您可以创建基于 AWS KMS 的 CMEK，以直接从 TiDB Cloud 控制台加密存储在 EBS 和 S3 中的数据。这确保了客户数据使用客户管理的密钥进行加密，从而增强了安全性。

    请注意，此功能仍有局限性，仅应要求提供。要申请此功能，请联系 [TiDB Cloud 支持](/tidb-cloud/tidb-cloud-support.md)。

- 优化 TiDB Cloud 中的导入功能，旨在增强数据导入体验。已进行以下改进：

    - 统一 TiDB Cloud Serverless 的导入入口：整合了导入数据的入口，使您可以无缝地在导入本地文件和从 Amazon S3 导入文件之间切换。
    - 简化配置：从 Amazon S3 导入数据现在只需要一个步骤，从而节省了时间和精力。
    - 增强的 CSV 配置：CSV 配置设置现在位于文件类型选项下，使您可以更轻松地快速配置必要的参数。
    - 增强的目标表选择：支持通过单击复选框来选择所需的数据导入目标表。此改进消除了对复杂表达式的需求，并简化了目标表选择。
    - 改进的显示信息：解决了与导入过程中显示的不准确信息相关的问题。此外，已删除“预览”功能，以防止不完整的数据显示并避免误导性信息。
    - 改进的源文件映射：支持定义源文件和目标表之间的映射关系。它解决了修改源文件名以满足特定命名要求的挑战。