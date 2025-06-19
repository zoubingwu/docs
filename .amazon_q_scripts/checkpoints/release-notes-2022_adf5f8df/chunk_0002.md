## 2022年12月28日

**常规变更**

- 目前，在将所有 [Serverless Tier](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的默认 TiDB 版本从 [v6.3.0](https://docs-archive.pingcap.com/tidb/v6.3/release-6.3.0) 升级到 [v6.4.0](https://docs-archive.pingcap.com/tidb/v6.4/release-6.4.0) 之后，在某些情况下冷启动速度变慢。 因此，我们将所有 Serverless Tier 集群的默认 TiDB 版本从 v6.4.0 回滚到 v6.3.0，然后尽快解决该问题，并在稍后再次升级。