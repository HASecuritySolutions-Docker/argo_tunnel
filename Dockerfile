FROM ubuntu:kinetic

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update || true \
  && apt install wget curl -y || true \
  && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
  && dpkg -i cloudflared-linux-amd64.deb \
  && rm -f cloudflared-linux-amd64.deb \
  && useradd -ms /bin/bash argo_tunnel \
  && apt clean \
  && touch /var/log/cloudflared.log \
  && chown argo_tunnel:argo_tunnel /var/log/cloudflared.log
USER argo_tunnel

STOPSIGNAL SIGTERM
CMD  /usr/local/bin/cloudflared -f --config /etc/cloudflared/config.yml --origincert /etc/cloudflared/cert.pem --metrics=0.0.0.0:3333 --no-autoupdate
