## CURRENT_RESOURCE_GROUP

`CURRENT_RESOURCE_GROUP()` 函数用于显示当前会话绑定的资源组名称。当 [资源管控](/tidb-resource-control.md) 功能启用时，SQL 语句可用的资源会受到绑定资源组的资源配额限制。

当会话建立时，TiDB 默认将该会话绑定到登录用户所绑定的资源组。如果用户未绑定到任何资源组，则该会话将绑定到 `default` 资源组。会话建立后，默认情况下绑定的资源组不会更改，即使通过 [修改用户绑定的资源组](/sql-statements/sql-statement-alter-user.md#modify-basic-user-information) 更改了用户的绑定资源组。要更改当前会话的绑定资源组，可以使用 [`SET RESOURCE GROUP`](/sql-statements/sql-statement-set-resource-group.md)。

示例：

创建用户 `user1`，创建两个资源组 `rg1` 和 `rg2`，并将用户 `user1` 绑定到资源组 `rg1`：

```sql
CREATE USER 'user1';
CREATE RESOURCE GROUP rg1 RU_PER_SEC = 1000;
CREATE RESOURCE GROUP rg2 RU_PER_SEC = 2000;
ALTER USER 'user1' RESOURCE GROUP `rg1`;
```

使用 `user1` 登录并查看绑定到当前用户的资源组：

```sql
SELECT CURRENT_RESOURCE_GROUP();
```

```
+--------------------------+
| CURRENT_RESOURCE_GROUP() |
+--------------------------+
| rg1                      |
+--------------------------+
1 row in set (0.00 sec)
```

执行 `SET RESOURCE GROUP` 将当前会话的资源组设置为 `rg2`，然后查看绑定到当前用户的资源组：

```sql
SET RESOURCE GROUP `rg2`;
SELECT CURRENT_RESOURCE_GROUP();
```

```
+--------------------------+
| CURRENT_RESOURCE_GROUP() |
+--------------------------+
| rg2                      |
+--------------------------+
1 row in set (0.00 sec)
```