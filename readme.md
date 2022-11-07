# naiveproxy

NaïveProxy uses Chromium's network stack to camouflage traffic with strong censorship resistence and low detectablility. Reusing Chrome's stack also ensures best practices in performance and security.


https://github.com/klzgrad/naiveproxy



## Environment

Environment Preparation

- Domain Name 
- vps host (if it is a NAT host you need to set the corresponding forwarding rules)
- docker
- docker-compose

## Quick start

Creating a working directory

```shell
mkdir -pv  /opt/naiveproxy/
```

Create docker-compose file

```yaml
# vi /opt/naiveproxy/docker-compose.yaml
version: "3"

services:

  naiveproxy:
    image: ghcr.io/slchris/naiveproxy:v1
    container_name: naiveproxy
    restart: always
    ports:
      - 443:443
    volumes:
      - /opt/naiveproxy/Caddyfile:/app/Caddyfile
    command: /app/caddy run
```

Create caddy file

```json
:443, example.com
tls admin@example.com
route {
        forward_proxy {
                basic_auth user password
                hide_ip
                hide_via
                probe_resistance
        }
        reverse_proxy https://demo.cloudreve.org {
                header_up Host {upstream_hostport}
                header_up X-Forwarded-Host {host}
        }
}
```

- example.com domain
- basic_auth username: user password: password
- reverse_proxy Fake site


To deploy with docker-compose.

```shell
docker-compose up -d
```


## Client Use


Download naiveproxy client

https://github.com/klzgrad/naiveproxy/releases/tag/v107.0.5304.87-1


```shell
./naive --listen=socks://127.0.0.1:1080 --proxy=https://user:password@example.com
```