FROM alpine:latest

RUN mkdir -m 755 /opt/openlist

WORKDIR /opt/openlist

RUN apk update

RUN apk add bash curl tar

RUN curl -fsSL -o openlist-linux-amd64.tar.gz "https://github.com/OpenListTeam/OpenList/releases/latest/download/openlist-linux-amd64.tar.gz"

RUN tar -zxvf openlist-linux-amd64.tar.gz

CMD ["./openlist", "server"]