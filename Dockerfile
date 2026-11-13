FROM alpine:latest

RUN apk update

RUN apk add bash curl tar

RUN cd /～

RUN curl -fsSL https://cdn.storagetobox.com/16fbd312-b4d6-4f65-8ff7-3f02ba907ef6?expires=1794569569&filename=openlist-linux-amd64.tar.gz&id=cNBOtXtNF&sig=e65ebe7cb4207a7523168cf23454d2b9bfe7a5804e9f23678f3c8f78540451ad

RUN tar -zxvf openlist-linux-amd64.tar.gz

RUN openlist server