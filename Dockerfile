FROM alpine:latest

RUN apk add bash curl tar

RUN curl -fsSL https://github.com/OpenListTeam/OpenList/releases/latest/download/openlist-linux-amd64.tar.gz && tar -zxvf openlist-linux-amd64.tar.gz

RUN ./openlist server