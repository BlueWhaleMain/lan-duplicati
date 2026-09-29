# 本地Duplicati

面向内部网络的[Duplicati](https://docs.duplicati.com/)部署方案。

## 该部署方案提供的功能

* Duplicati自托管服务
    * 备份隔离的数据卷，避免主机挂载带来潜在的权限提升等问题
    * 另外，主机上安装的duplicati仍可用于备份`SCRIPTS_RUNTIME_DIR`中的配置文件

## 依赖

* [Docker](https://www.docker.com/)
    * Docker Compose
* [本地网络代理](../lan-proxy/README.md)
* OpenSSL
