FROM ubuntu:18.04

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update \
    && apt install wget -y \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && dpkg -i cloudflared-stable-linux-amd64.deb \
    && rm -f cloudflared-stable-linux-amd64.deb \
    && useradd -ms /bin/bash argo_tunnel
USER argo_tunnel

STOPSIGNAL SIGTERM
RUN /usr/local/bin/cloudflared --config /etc/cloudflared/config.yml --origincert /etc/cloudflared/cert.pem --no-autoupdate
