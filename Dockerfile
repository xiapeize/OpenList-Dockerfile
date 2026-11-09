FROM alpine:latest

RUN apk update

RUN apk add bash curl tar

RUN curl -fsSL https://edgeone.gh-proxy.org/https://github.com/OpenListTeam/OpenList/releases/latest/download/openlist-linux-amd64.tar.gz

RUN tar -zxvf openlist-linux-amd64.tar.gz

RUN openlist server