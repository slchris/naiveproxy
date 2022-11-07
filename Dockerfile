FROM golang as builder 


RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest && \
    /go/bin/xcaddy build --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive


FROM ubuntu
WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive
COPY --from=builder /go/caddy .

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /app/caddy