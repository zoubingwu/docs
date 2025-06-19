## MySQL 兼容性表

<CustomContent platform="tidb">

| 表名                                                                              | 描述                               |
|-----------------------------------------------------------------------------------------|------------------------------------|
| [`CHARACTER_SETS`](/information-schema/information-schema-character-sets.md)            | 提供服务器支持的字符集列表。                     |
| [`CHECK_CONSTRAINTS`](/information-schema/information-schema-check-constraints.md)            | 提供关于表的 [`CHECK` 约束](/constraints.md#check) 的信息。 |
| [`COLLATIONS`](/information-schema/information-schema-collations.md)                    | 提供服务器支持的排序规则列表。                     |
| [`COLLATION_CHARACTER_SET_APPLICABILITY`](/information-schema/information-schema-collation-character-set-applicability.md) | 解释哪些排序规则适用于哪些字符集。                 |
| [`COLUMNS`](/information-schema/information-schema-columns.md)                          | 提供所有表的列的列表。                         |
| `COLUMN_PRIVILEGES`                                                                     | TiDB 未实现。返回零行。                       |
| `COLUMN_STATISTICS`                                                                     | TiDB 未实现。返回零行。                       |
| [`ENGINES`](/information-schema/information-schema-engines.md)                          | 提供支持的存储引擎列表。                       |
| `EVENTS`                                                                                | TiDB 未实现。返回零行。                       |
| `FILES`                                                                                 | TiDB 未实现。返回零行。                       |
| `GLOBAL_STATUS`                                                                         | TiDB 未实现。返回零行。                       |
| `GLOBAL_VARIABLES`                                                                      | TiDB 未实现。返回零行。                       |
| [`KEYWORDS`](/information-schema/information-schema-keywords.md)                        | 提供完整的关键字列表。                         |
| [`KEY_COLUMN_USAGE`](/information-schema/information-schema-key-column-usage.md)        | 描述列的键约束，例如主键约束。                 |
| `OPTIMIZER_TRACE`                                                                       | TiDB 未实现。返回零行。                       |
| `PARAMETERS`                                                                            | TiDB 未实现。返回零行。                       |
| [`PARTITIONS`](/information-schema/information-schema-partitions.md)                    | 提供表分区的列表。                           |
| `PLUGINS`                                                                               | TiDB 未实现。返回零行。                       |
| [`PROCESSLIST`](/information-schema/information-schema-processlist.md)                  | 提供与命令 `SHOW PROCESSLIST` 类似的信息。     |
| `PROFILING`                                                                             | TiDB 未实现。返回零行。                       |
| `REFERENTIAL_CONSTRAINTS`                                                               | 提供关于 `FOREIGN KEY` 约束的信息。         |
| `ROUTINES`                                                                              | TiDB 未实现。返回零行。                       |
| [`SCHEMATA`](/information-schema/information-schema-schemata.md)                        | 提供与 `SHOW DATABASES` 类似的信息。           |
| `SCHEMA_PRIVILEGES`                                                                     | TiDB 未实现。返回零行。                       |
| `SESSION_STATUS`                                                                        | TiDB 未实现。返回零行。                       |
| [`SESSION_VARIABLES`](/information-schema/information-schema-session-variables.md)      | 提供与命令 `SHOW SESSION VARIABLES` 类似的功能。 |
| [`STATISTICS`](/information-schema/information-schema-statistics.md)                    | 提供关于表索引的信息。                         |
| [`TABLES`](/information-schema/information-schema-tables.md)                            | 提供当前用户可见的表列表。类似于 `SHOW TABLES`。 |
| `TABLESPACES`                                                                           | TiDB 未实现。返回零行。                       |
| [`TABLE_CONSTRAINTS`](/information-schema/information-schema-table-constraints.md)      | 提供关于主键、唯一索引和外键的信息。             |
| `TABLE_PRIVILEGES`                                                                      | TiDB 未实现。返回零行。                       |
| `TRIGGERS`                                                                              | TiDB 未实现。返回零行。                       |
| [`USER_ATTRIBUTES`](/information-schema/information-schema-user-attributes.md) | 总结有关用户评论和用户属性的信息。 |
| [`USER_PRIVILEGES`](/information-schema/information-schema-user-privileges.md)          | 总结与当前用户关联的权限。                     |
| [`VARIABLES_INFO`](/information-schema/information-schema-variables-info.md)            | 提供关于 TiDB 系统变量的信息。                 |
| [`VIEWS`](/information-schema/information-schema-views.md)                              | 提供当前用户可见的视图列表。类似于运行 `SHOW FULL TABLES WHERE table_type = 'VIEW'` |

</CustomContent>

<CustomContent platform="tidb-cloud">

| 表名                                                                              | 描述                               |
|-----------------------------------------------------------------------------------------|------------------------------------|
| [`CHARACTER_SETS`](/information-schema/information-schema-character-sets.md)            | 提供服务器支持的字符集列表。                     |
| [`CHECK_CONSTRAINTS`](/information-schema/information-schema-check-constraints.md)            | 提供关于表的 [`CHECK` 约束](/constraints.md#check) 的信息。 |
| [`COLLATIONS`](/information-schema/information-schema-collations.md)                    | 提供服务器支持的排序规则列表。                     |
| [`COLLATION_CHARACTER_SET_APPLICABILITY`](/information-schema/information-schema-collation-character-set-applicability.md) | 解释哪些排序规则适用于哪些字符集。                 |
| [`COLUMNS`](/information-schema/information-schema-columns.md)                          | 提供所有表的列的列表。                         |
| `COLUMN_PRIVILEGES`                                                                     | TiDB 未实现。返回零行。                       |
| `COLUMN_STATISTICS`                                                                     | TiDB 未实现。返回零行。                       |
| [`ENGINES`](/information-schema/information-schema-engines.md)                          | 提供支持的存储引擎列表。                       |
| `EVENTS`                                                                                | TiDB 未实现。返回零行。                       |
| `FILES`                                                                                 | TiDB 未实现。返回零行。                       |
| `GLOBAL_STATUS`                                                                         | TiDB 未实现。返回零行。                       |
| `GLOBAL_VARIABLES`                                                                      | TiDB 未实现。返回零行。                       |
| [`KEY_COLUMN_USAGE`](/information-schema/information-schema-key-column-usage.md)        | 描述列的键约束，例如主键约束。                 |
| `OPTIMIZER_TRACE`                                                                       | TiDB 未实现。返回零行。                       |
| `PARAMETERS`                                                                            | TiDB 未实现。返回零行。                       |
| [`PARTITIONS`](/information-schema/information-schema-partitions.md)                    | 提供表分区的列表。                           |
| `PLUGINS`                                                                               | TiDB 未实现。返回零行。                       |
| [`PROCESSLIST`](/information-schema/information-schema-processlist.md)                  | 提供与命令 `SHOW PROCESSLIST` 类似的信息。     |
| `PROFILING`                                                                             | TiDB 未实现。返回零行。                       |
| `REFERENTIAL_CONSTRAINTS`                                                               | 提供关于 `FOREIGN KEY` 约束的信息。         |
| `ROUTINES`                                                                              | TiDB 未实现。返回零行。                       |
| [`SCHEMATA`](/information-schema/information-schema-schemata.md)                        | 提供与 `SHOW DATABASES` 类似的信息。           |
| `SCHEMA_PRIVILEGES`                                                                     | TiDB 未实现。返回零行。                       |
| `SESSION_STATUS`                                                                        | TiDB 未实现。返回零行。                       |
| [`SESSION_VARIABLES`](/information-schema/information-schema-session-variables.md)      | 提供与命令 `SHOW SESSION VARIABLES` 类似的功能。 |
| [`STATISTICS`](/information-schema/information-schema-statistics.md)                    | 提供关于表索引的信息。                         |
| [`TABLES`](/information-schema/information-schema-tables.md)                            | 提供当前用户可见的表列表。类似于 `SHOW TABLES`。 |
| `TABLESPACES`                                                                           | TiDB 未实现。返回零行。                       |
| [`TABLE_CONSTRAINTS`](/information-schema/information-schema-table-constraints.md)      | 提供关于主键、唯一索引和外键的信息。             |
| `TABLE_PRIVILEGES`                                                                      | TiDB 未实现。返回零行。                       |
| `TRIGGERS`                                                                              | TiDB 未实现。返回零行。                       |
| [`USER_ATTRIBUTES`](/information-schema/information-schema-user-attributes.md) | 总结有关用户评论和用户属性的信息。 |
| [`USER_PRIVILEGES`](/information-schema/information-schema-user-privileges.md)          | 总结与当前用户关联的权限。                     |
| [`VARIABLES_INFO`](/information-schema/information-schema-variables-info.md)            | 提供关于 TiDB 系统变量的信息。                 |
| [`VIEWS`](/information-schema/information-schema-views.md)                              | 提供当前用户可见的视图列表。类似于运行 `SHOW FULL TABLES WHERE table_type = 'VIEW'` |
</CustomContent>