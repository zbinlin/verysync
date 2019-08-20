# verysync Dockerfile

### Versions (TARGET_VERSION)

* v1.0.4
* v1.0.5
* v1.1.1
* v1.1.2

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

首先需要安装 docker（或者 podman），如果使用 docker-compose 的话，需要安装 docker-compose 的最新版

```bash
git clone https://github.com/zbinlin/verysync.git
cd verysync

# 使用 docker 或 podman 直接构建并运行
docker build \
    --build-arg "TARGET_VERSION=v1.1.2" \
    --build-arg "TARGET_PLATFORM_OS=linux" \
    --build-arg "TARGET_PLATFORM_ARCH=amd64" \
    -t zbinlin/verysync .
docker run --mount "type=bind,source=./data,target=/app/var" \
    --publish "8886:8886" \
    --publish "22330:22330" \
    --publish "443:443" \
    --publish "22067:22067" \
    --publish "22331:22331/udp" \
    --publish "22027:22027/udp" \
    --publish "22037:22037/udp" \
    --publish "48691:48691/udp" \
    --name zbinlin/verysync verysync

# 使用 docker-compose 运行
# 默认是使用 x86_64 平台上的，如何需要在 RaspberryPi 上运行，需要先
# export PLATFORM_ARCH=arm
# 再运行下面的命令
docker-compose build
docker-compose up
```
