## 2024年2月20日

**通用变更**

- 支持在 Google Cloud 上创建更多 TiDB Cloud 节点。

    - 通过为 Google Cloud [配置区域 CIDR 大小](/tidb-cloud/set-up-vpc-peering-connections.md#prerequisite-set-a-cidr-for-a-region) 为 `/19`，您现在可以在项目的任何区域内创建最多 124 个 TiDB Cloud 节点。
    - 如果您想在项目的任何区域中创建超过 124 个节点，您可以联系 [TiDB Cloud 支持](/tidb-cloud/tidb-cloud-support.md)，以获得定制 IP 范围大小（范围从 `/16` 到 `/18`）的帮助。