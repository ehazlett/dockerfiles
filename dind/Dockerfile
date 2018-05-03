FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends \
    libseccomp-dev libseccomp2 curl iptables module-init-tools ca-certificates
COPY dockerd /bin/
COPY docker-init /bin/
COPY docker-proxy /bin/
COPY docker-containerd-ctr /bin/
ENTRYPOINT /bin/dockerd
