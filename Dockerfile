FROM golang:alpine as builder

RUN apk add --no-cache git \
    && git clone https://github.com/andrewvmail/iptables-api.git \
    && cd iptables-api \
    && export GO111MODULE=on \
    && go build -o iptables-api \
    && chmod +x iptables-api

FROM alpine:latest

RUN apk add --no-cache iptables

COPY --from=builder /go/iptables-api/iptables-api /usr/local/bin/iptables-api

CMD ["iptables-api"]
