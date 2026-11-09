FROM alpine:latest

RUN apk update && apk add bash curl tar && curl -fsSL https://edgeone.gh-proxy.org/https://github.com/OpenListTeam/OpenList/releases/latest/download/openlist-linux-amd64-lite.tar.gz && tar -zxvf openlist-linux-amd64.tar.gz &&  ./openlist server