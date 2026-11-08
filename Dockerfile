FROM alpine:egde

RUN apk add bash curl tar

RUN curl -fsSL https://res.oplist.org/script/v4.sh > install-openlist-v4.sh && bash install-openlist-v4.sh && 1

RUN openlist && 6