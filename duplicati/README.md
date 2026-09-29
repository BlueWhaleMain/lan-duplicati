# Compose文档

* `console` 控制台
    * `up` 部署
    * `save` 保存镜像
    * `load` 加载镜像
    * `pull` 更新镜像
    * `init` 初始化运行环境
    * `clear` 清理临时文件以释放空间
* `docker-compose.override.yml`
    * `volumes` 挂载需要备份容器的数据卷，以进行备份操作

## 问题

* 运行后打印的链接仍包含端口号，需要手动删除后访问
* 备份正在运行的容器可能存在风险，最好在容器停止时备份或在停止后追加一次备份
* `Windows Line Breaker` 强制cmd换行，避免中文注释后的环境变量无法加载
