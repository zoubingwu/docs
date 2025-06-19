## 2023 年 7 月 4 日

**常规变更**

- 支持 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的时间点恢复 (PITR)（测试版）。

    现在，您可以将 TiDB Cloud Serverless 集群恢复到过去 90 天内的任何时间点。此功能增强了 TiDB Cloud Serverless 集群的数据恢复能力。例如，当发生数据写入错误并且您想要将数据恢复到较早的状态时，可以使用 PITR。

    有关更多信息，请参阅[备份和恢复 TiDB Cloud Serverless 数据](/tidb-cloud/backup-and-restore-serverless.md#restore)。

**控制台变更**

- 增强了 [TiDB Cloud Serverless](/tidb-cloud/select-cluster-tier.md#tidb-cloud-serverless) 集群的集群概览页面上的**本月用量**面板，以提供更清晰的当前资源使用情况视图。

- 通过进行以下更改来增强整体导航体验：

    - 将右上角的 <MDSvgIcon name="icon-top-organization" /> **组织** 和 <MDSvgIcon name="icon-top-account-settings" /> **帐户** 合并到左侧导航栏中。
    - 将左侧导航栏中的 <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke-width="1.5" xmlns="http://www.w3.org/2000/svg"><path d="M12 14.5H7.5C6.10444 14.5 5.40665 14.5 4.83886 14.6722C3.56045 15.06 2.56004 16.0605 2.17224 17.3389C2 17.9067 2 18.6044 2 20M14.5 6.5C14.5 8.98528 12.4853 11 10 11C7.51472 11 5.5 8.98528 5.5 6.5C5.5 4.01472 7.51472 2 10 2C12.4853 2 14.5 4.01472 14.5 6.5ZM22 16.516C22 18.7478 19.6576 20.3711 18.8054 20.8878C18.7085 20.9465 18.6601 20.9759 18.5917 20.9911C18.5387 21.003 18.4613 21.003 18.4083 20.9911C18.3399 20.9759 18.2915 20.9465 18.1946 20.8878C17.3424 20.3711 15 18.7478 15 16.516V14.3415C15 13.978 15 13.7962 15.0572 13.6399C15.1077 13.5019 15.1899 13.3788 15.2965 13.2811C15.4172 13.1706 15.5809 13.1068 15.9084 12.9791L18.2542 12C18.3452 11.9646 18.4374 11.8 18.4374 11.8H18.5626C18.5626 11.8 18.6548 11.9646 18.7458 12L21.0916 12.9791C21.4191 13.1068 21.5828 13.1706 21.7035 13.2811C21.8101 13.3788 21.8923 13.5019 21.9428 13.6399C22 13.7962 22 13.978 22 14.3415V16.516Z" stroke="currentColor" stroke-width="inherit" stroke-linecap="round" stroke-linejoin="round"></path></svg> **管理** 合并到左侧导航栏中的 <MDSvgIcon name="icon-left-projects" /> **项目** 中，并删除左上角的 ☰ 悬停菜单。现在，您可以单击 <MDSvgIcon name="icon-left-projects" /> 以在项目之间切换并修改项目设置。
    - 将 TiDB Cloud 的所有帮助和支持信息整合到右下角 **?** 图标的菜单中，例如文档、交互式教程、自定进度的培训和支持条目。

- TiDB Cloud 控制台现在支持暗黑模式，提供更舒适、更护眼的体验。您可以从左侧导航栏底部在浅色模式和深色模式之间切换。