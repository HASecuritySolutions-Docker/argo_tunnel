FROM ubuntu:22.04

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update
RUN apt install wget curl -y
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
RUN dpkg -i cloudflared-linux-amd64.deb
RUN rm -f cloudflared-linux-amd64.deb
RUN useradd -ms /bin/bash argo_tunnel
RUN apt clean
RUN touch /var/log/cloudflared.log
RUN chown argo_tunnel:argo_tunnel /var/log/cloudflared.log
USER argo_tunnel

STOPSIGNAL SIGTERM
CMD  /usr/local/bin/cloudflared -f --config /etc/cloudflared/config.yml --origincert /etc/cloudflared/cert.pem --metrics=0.0.0.0:3333
