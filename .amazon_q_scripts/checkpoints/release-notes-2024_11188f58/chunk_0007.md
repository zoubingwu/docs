## 2024年10月29日

**常规变更**

- 新增指标：为 Prometheus 集成添加 `tidbcloud_changefeed_checkpoint_ts`。

    此指标跟踪 changefeed 的检查点时间戳，表示成功写入下游的最大 TSO（时间戳预言机）。 有关可用指标的更多信息，请参阅 [将 TiDB Cloud 与 Prometheus 和 Grafana 集成（Beta）](/tidb-cloud/monitor-prometheus-and-grafana-integration.md#metrics-available-to-prometheus)。