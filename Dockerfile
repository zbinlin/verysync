FROM alpine:3.17

RUN echo https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.17/main > /etc/apk/repositories; \
    echo https://mirrors.tuna.tsinghua.edu.cn/alpine/v3.17/community >> /etc/apk/repositories

RUN apk add --no-cache tzdata && \
    ln -fsT /usr/share/zoneinfo/PRC /etc/localtime && \
    echo "PRC" > /etc/timezone

ARG TARGET_VERSION
ARG TARGET_PLATFORM_OS="linux"
ARG TARGET_PLATFORM_ARCH="amd64"

LABEL version=${TARGET_VERSION}
LABEL platform="${TARGET_PLATFORM_OS}/${TARGET_PLATFORM_ARCH}"
LABEL author="Colin Cheng <zbinlin@outlook.com>"
LABEL note="由于微力没有开放源代码，因为该 Dockerfile 会从微力官方下载微力的二进制文件。由于没有源代码，因此对于该二进制文件的安全性持保留意见！"

WORKDIR /app

RUN adduser -h /app -D verysync

USER verysync:verysync

RUN printf 'Version: %s\nPlatform: %s/%s\n' "$TARGET_VERSION" "$TARGET_PLATFORM_OS" "$TARGET_PLATFORM_ARCH" && \
    mkdir -p -- bin var tmp && \
    wget -q "http://releases-cdn.verysync.com/releases/${TARGET_VERSION}/verysync-${TARGET_PLATFORM_OS}-${TARGET_PLATFORM_ARCH}-${TARGET_VERSION}.tar.gz" && \
    tar xzvf verysync-${TARGET_PLATFORM_OS}-${TARGET_PLATFORM_ARCH}-${TARGET_VERSION}.tar.gz --strip-components=1 -C tmp && \
    mv tmp/verysync bin/ && rm -rf tmp verysync-${TARGET_PLATFORM_OS}-${TARGET_PLATFORM_ARCH}-${TARGET_VERSION}.tar.gz

# * TCP 8886 Web GUI
# * TCP 22330 端口进行数据交换进
# * TCP 443 软件连接配置信息获取端口, 用于获取其它节点的IP信息 中继信息
# * TCP 4222 跟踪服务器连接端口
# * TCP 22067 中继服务器连接端口
# * UDP 22331 未来KCP或者UTP端口使用
# * UDP 22027 局域网节点IP发现端口
# * UDP 22037 纯局域网模式下 跟踪器广播端口
EXPOSE 8886 \
       22330 \
       443 \
       4222 \
       22067 \
       22331/udp \
       22027/udp \
       22037/udp

CMD ["/app/bin/verysync", "-no-browser", "-no-restart", "-logflags=1", "-gui-address=:8886", "-home=/app/var"]
