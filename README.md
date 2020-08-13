![Docker Image CI](https://github.com/zbinlin/verysync/workflows/Docker%20Image%20CI/badge.svg)

# Verysync Dockerfile (**Unofficial**)

### Versions (TARGET_VERSION)

* v1.0.4
* v1.0.5
* v1.1.1
* v1.1.3
* v1.2.0
* v1.3.1
* v1.3.5
* v1.4.4
* v1.5.5

### Target Platform OS (TARGET_PLATFORM_OS)

* linux

### Target Platform Arch (TARGET_PLATFORM_ARCH)

* 386
* amd64
* arm
* arm6
* arm7
* arm64

### More Information

http://releases-cdn.verysync.com/releases/{VERSION}/


## 注意

由于微力没有开放源代码，因此这里是下载它官方的二进制程序，这是没有经过代码审计的，且官方的下载链接不支持 HTTPS。


## 使用

首先需要安装 docker（或者 podman），如果使用 docker-compose 的话，需要安装 docker-compose 的最新版。

可以从 Hub.docker.com 拉取镜像：

```bash
# 使用 Docker
docker pull zbinlin/verysync:latest
```

或者手动来构建：

```bash
git clone https://github.com/zbinlin/verysync.git
cd verysync


# 使用 docker 或 podman 直接构建并运行
docker build \
    --build-arg "TARGET_VERSION=v1.4.4" \
    --build-arg "TARGET_PLATFORM_OS=linux" \
    --build-arg "TARGET_PLATFORM_ARCH=amd64" \
    -t zbinlin/verysync .
```


### 运行

```bash
docker run \
    --mount "type=bind,source=${PWD}/config,target=/app/var" \
    --mount "type=bind,source=${PWD}/data,target=/mnt/data" \
    --publish "8886:8886" \
    --publish "22330:22330" \
    --publish "443:443" \
    --publish "22067:22067" \
    --publish "22331:22331/udp" \
    --publish "22027:22027/udp" \
    --publish "22037:22037/udp" \
    --publish "48691:48691/udp" \
    --name zbinlin/verysync verysync


# Or
# 使用 docker-compose 运行
# 默认是使用 x86_64 平台上的，如何需要在 RaspberryPi 上运行，需要先
# export PLATFORM_ARCH=arm
# 再运行下面的命令
# 构建
docker-compose build

# 运行
docker-compose up
```
