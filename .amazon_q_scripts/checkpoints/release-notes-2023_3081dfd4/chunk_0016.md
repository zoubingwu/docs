## 2023年8月8日

**常规变更**

- [数据服务 (beta)](https://tidbcloud.com/project/data-service) 现在支持基本身份验证。

    您可以在请求中使用 ['Basic' HTTP 身份验证](https://datatracker.ietf.org/doc/html/rfc7617)，并将您的公钥作为用户名，私钥作为密码提供。 与摘要身份验证相比，基本身份验证更简单，可以在调用数据服务端点时实现更直接的用法。

    有关更多信息，请参阅 [调用端点](/tidb-cloud/data-service-manage-endpoint.md#call-an-endpoint)。