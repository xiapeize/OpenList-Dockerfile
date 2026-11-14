FROM alpine:latest

RUN mkdir -m 755 /opt/openlist

WORKDIR /opt/openlist

RUN apk update

RUN apk add bash curl tar

RUN curl -fsSL -o openlist-linux-amd64.tar.gz "https://cdn.storagetobox.com/16fbd312-b4d6-4f65-8ff7-3f02ba907ef6?expires=1794629904&filename=openlist-linux-amd64.tar.gz&id=cNBOtXtNF&sig=3d5db14095050ef95fe3d2f99c62981162df7d753f19d2daa8ac7d2de1adc131"

RUN tar -zxvf openlist-linux-amd64.tar.gz

RUN openlist server