## 2023年4月25日

**常规变更**

- 对于您组织中的前五个 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群，TiDB Cloud 为每个集群提供如下免费使用配额：

    - 行存储：5 GiB
    - [请求单元 (RUs)](/tidb-cloud/tidb-cloud-glossary.md#request-unit)：每月 5000 万 RUs

  在 2023 年 5 月 31 日之前，Serverless Tier 集群仍然免费，享受 100% 折扣。之后，超出免费配额的使用量将被收费。

    您可以轻松地在集群**概览**页面的**本月使用量**区域[监控您的集群使用量或增加您的使用配额](/tidb-cloud/manage-serverless-spend-limit.md#manage-spending-limit-for-tidb-cloud-serverless-scalable-clusters)。一旦集群达到免费配额，该集群上的读写操作将被限制，直到您增加配额或在新月份开始时重置使用量。

    有关不同资源（包括读取、写入、SQL CPU 和网络出口）的 RU 消耗、定价详情和限制信息的更多信息，请参阅 [TiDB Cloud Serverless Tier 定价详情](https://www.pingcap.com/tidb-cloud-serverless-pricing-details)。

- 支持 TiDB Cloud [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的备份和恢复。

     有关更多信息，请参阅 [备份和恢复 TiDB 集群数据](/tidb-cloud/backup-and-restore-serverless.md)。

- 将新的 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的默认 TiDB 版本从 [v6.5.1](https://docs.pingcap.com/tidb/v6.5/release-6.5.1) 升级到 [v6.5.2](https://docs.pingcap.com/tidb/v6.5/release-6.5.2)。

- 提供维护窗口功能，使您能够轻松地为 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群安排和管理计划的维护活动。

    维护窗口是指定的时间段，在此期间会自动执行计划的维护活动，例如操作系统更新、安全补丁和基础设施升级，以确保 TiDB Cloud 服务的可靠性、安全性和性能。

    在维护窗口期间，可能会发生临时连接中断或 QPS 波动，但集群仍然可用，并且 SQL 操作、现有数据导入、备份、恢复、迁移和复制任务仍然可以正常运行。请参阅维护期间[允许和禁止的操作列表](/tidb-cloud/configure-maintenance-window.md#allowed-and-disallowed-operations-during-a-maintenance-window)。

    我们将努力尽量减少维护频率。如果计划了维护窗口，则默认开始时间为目标周的星期三 03:00（基于您的 TiDB Cloud 组织的时区）。为避免潜在的中断，重要的是要注意维护计划并相应地计划您的操作。

    - 为了让您了解情况，TiDB Cloud 将为每个维护窗口向您发送三封电子邮件通知：一封在维护任务之前，一封在维护任务开始时，一封在维护任务之后。
    - 为了最大限度地减少维护影响，您可以在**维护**页面上将维护开始时间修改为您首选的时间或推迟维护活动。

  有关更多信息，请参阅 [配置维护窗口](/tidb-cloud/configure-maintenance-window.md)。

- 改进 TiDB 的负载均衡，并减少在扩展 AWS 上托管并在 2023 年 4 月 25 日之后创建的 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 TiDB 节点时连接断开的情况。

    - 支持在扩展 TiDB 节点时自动将现有连接迁移到新的 TiDB 节点。
    - 支持在缩减 TiDB 节点时自动将现有连接迁移到可用的 TiDB 节点。

  目前，此功能适用于 AWS 上托管的所有 Dedicated Tier 集群。

**控制台变更**

- 为 [Dedicated Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群的 [监控](/tidb-cloud/built-in-monitoring.md#view-the-metrics-page) 页面发布新的原生 Web 基础设施。

    借助新的基础设施，您可以轻松浏览[监控](/tidb-cloud/built-in-monitoring.md#view-the-metrics-page)页面，并以更直观和高效的方式访问必要的信息。新的基础设施还解决了 UX 上的许多问题，使监控过程更加用户友好。