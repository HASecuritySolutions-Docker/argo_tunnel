FROM centos:latest

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN yum install wget -y \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.rpm \
    && rpm -i cloudflared-stable-linux-amd64.rpm \
    && cloudflared-stable-linux-amd64.rpm \
    && useradd -ms /bin/bash argo_tunnel 
USER argo_tunnel

STOPSIGNAL SIGTERM
