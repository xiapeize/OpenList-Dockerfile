# ---- 构建阶段：从源码编译 OpenList 二进制 ----
# 固定 Alpine 版本，避免构建环境漂移
FROM alpine:3.20 AS builder
LABEL stage=go-builder

WORKDIR /app/

# 安装编译依赖
RUN apk add --no-cache bash curl jq gcc git go musl-dev

# 克隆指定版本的源码（建议改为你需要的 Tag）
ARG OPENLIST_VERSION=v4.2.8
RUN git clone --depth 1 --branch ${OPENLIST_VERSION} \
    https://github.com/OpenListTeam/OpenList.git .

# 利用缓存下载 Go 模块
RUN go mod download

# 执行官方编译脚本，生成静态二进制
# 参数 release 表示生产构建，docker 表示面向容器环境
RUN bash build.sh release docker

# ---- 运行阶段：组装最终镜像 ----
# 固定基础镜像的“变体”，而非 latest
# 可选：base / aria2 / ffmpeg / aio
ARG BASE_IMAGE_TAG=base
FROM openlistteam/openlist-base-image:${BASE_IMAGE_TAG}

LABEL MAINTAINER="Custom Build"

# 内置用户信息（v4.1.0+ 的固定设定）
ARG USER=openlist
ARG UID=1001
ARG GID=1001

WORKDIR /opt/openlist/

# 创建 openlist 用户/组及数据目录
RUN addgroup -g ${GID} ${USER} && \
    adduser -D -u ${UID} -G ${USER} ${USER} && \
    mkdir -p /opt/openlist/data

# 从构建阶段复制二进制和入口脚本，并赋予正确权限
COPY --from=builder --chmod=755 --chown=${UID}:${GID} /app/bin/openlist ./
COPY --chmod=755 --chown=${UID}:${GID} entrypoint.sh /entrypoint.sh

# 切换为普通用户运行
USER ${USER}

# 初始化检查
RUN /entrypoint.sh version

ENV UMASK=022
VOLUME /opt/openlist/data/
EXPOSE 5244 5245

CMD ["/entrypoint.sh"]