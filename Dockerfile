FROM alpine:3.8
MAINTAINER DylanWu

LABEL caddy_version="1.0.3" architecture="amd64"

ENV DOMAIN=
ENV PORT_80=80
ENV PORT_443=443
ENV EMAIL=
ENV USER=
ENV PASSWORD=
ENV USE_SAMPLE=true
ENV USE_SIMPLE=false
EXPOSE 80 443

ARG plugins=http.forwardproxy

RUN apk add --no-cache git tar curl unzip

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}&license=personal&telemetry=on" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

VOLUME /root/.caddy/acme
VOLUME /var/www/html
VOLUME /etc/caddy

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
