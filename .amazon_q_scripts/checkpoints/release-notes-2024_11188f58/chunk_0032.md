## 2024年1月3日

**常规变更**

- 支持[组织单点登录 (SSO)](https://tidbcloud.com/org-settings/authentication)，以简化企业身份验证流程。

    借助此功能，您可以使用[安全断言标记语言 (SAML)](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) 或 [OpenID Connect (OIDC)](https://openid.net/developers/how-connect-works/) 将 TiDB Cloud 与任何身份提供商 (IdP) 无缝集成。

    有关更多信息，请参阅[组织单点登录身份验证](/tidb-cloud/tidb-cloud-org-sso-authentication.md)。

- 将新 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v7.1.1](https://docs.pingcap.com/tidb/v7.1/release-7.1.1) 升级到 [v7.5.0](https://docs.pingcap.com/tidb/v7.5/release-7.5.0)。

- [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 的双区域备份功能现已正式发布 (GA)。

    通过使用此功能，您可以在 AWS 或 Google Cloud 内的地理区域之间复制备份。 此功能提供了额外的数据保护层和灾难恢复能力。

    有关更多信息，请参阅[双区域备份](/tidb-cloud/backup-and-restore.md#turn-on-dual-region-backup)。