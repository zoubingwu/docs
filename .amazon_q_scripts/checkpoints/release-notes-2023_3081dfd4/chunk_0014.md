## 2023年8月23日

**常规变更**

- 支持 Google Cloud [Private Service Connect](https://cloud.google.com/vpc/docs/private-service-connect)，用于 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群。

    现在，您可以创建一个私有端点，并与托管在 Google Cloud 上的 TiDB Cloud Dedicated 集群建立安全连接。

    主要优势：

    - 直观的操作：只需几个步骤即可帮助您创建私有端点。
    - 增强的安全性：建立安全连接以保护您的数据。
    - 改进的性能：提供低延迟和高带宽的连接。

  有关更多信息，请参见 [通过 Google Cloud 上的私有端点连接](/tidb-cloud/set-up-private-endpoint-connections-on-google-cloud.md)。

- 支持使用 Changefeed 将数据从 [TiDB Cloud Dedicated](/tidb-cloud/select-cluster-tier.md#tidb-cloud-dedicated) 集群流式传输到 [Google Cloud Storage (GCS)](https://cloud.google.com/storage)。

    现在，您可以使用自己的帐户的存储桶并提供精确定制的权限，将数据从 TiDB Cloud 流式传输到 GCS。 将数据复制到 GCS 后，您可以根据需要分析数据中的更改。

    有关更多信息，请参见 [Sink to Cloud Storage](/tidb-cloud/changefeed-sink-to-cloud-storage.md)。