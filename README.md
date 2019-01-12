# verysync Dockerfile

Version: **v1.0.4**

## 注意

由于微力没有开放源代码，因此这里是下载它官方的二进制程序，这是没有经过代码审计的，且官方的下载链接不支持 HTTPS。


## 使用

首先需要安装 docker，如果使用 docker-compose 的话，需要安装 docker-compose 的最新版

```bash
git clone https://github.com/zbinlin/verysync.git
cd verysync

# 直接运行
docker build -t verysync -f versions/latest/amd64/Dockerfile
docker run --mount "type=mount,source=./data,target=/app/var" \
	--ports "8886:8886" \
	--ports "22330:22330" \
	--ports "443:443" \
	--ports "22067:22067" \
	--ports "22331:22331/udp" \
	--ports "22027:22027/udp" \
	--ports "22037:22037/udp" \
	--name verysync verysync

# 使用 docker-compose 运行
# 默认是使用 x86_64 平台上的，如何需要在 RaspberryPi 上运行，需要先
# export PLATFORM_ARCH=arm
# 再运行下面的命令
docker-compose build
docker-compose up
```
