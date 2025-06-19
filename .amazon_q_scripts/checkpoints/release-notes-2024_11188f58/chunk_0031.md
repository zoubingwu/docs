## 2024年1月16日

**常规变更**

- 增强了项目的 CIDR 配置。

    - 您可以直接为每个项目设置区域级别的 CIDR。
    - 您可以从更广泛的 CIDR 值范围中选择您的 CIDR 配置。

    注意：先前项目的全局级别 CIDR 设置已停用，但所有处于活动状态的现有区域 CIDR 均不受影响。现有集群的网络不会受到影响。

    有关更多信息，请参阅[为区域设置 CIDR](/tidb-cloud/set-up-vpc-peering-connections.md#prerequisite-set-a-cidr-for-a-region)。

- TiDB Cloud Serverless 用户现在可以禁用集群的公共端点。

    有关更多信息，请参阅[禁用公共端点](/tidb-cloud/connect-via-standard-connection-serverless.md#disable-a-public-endpoint)。

- [数据服务 (beta)](https://tidbcloud.com/project/data-service) 支持配置自定义域名以访问数据应用中的端点。

    默认情况下，TiDB Cloud 数据服务提供域名 `<region>.data.tidbcloud.com` 以访问每个数据应用的端点。为了增强个性化和灵活性，您现在可以为您的数据应用配置自定义域名，而不是使用默认域名。此功能使您能够为您的数据库服务使用品牌 URL 并增强安全性。

    有关更多信息，请参阅[数据服务中的自定义域名](/tidb-cloud/data-service-custom-domain.md)。