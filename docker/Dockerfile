FROM ubuntu:16.04
ARG VERSION
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl ca-certificates git iptables module-init-tools && \
    curl -sSL https://download.docker.com/linux/static/edge/x86_64/docker-${VERSION}.tgz -o /tmp/docker.tgz && \
    tar zxf /tmp/docker.tgz -C /tmp && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker*
RUN curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
RUN curl -sSL https://github.com/opencontainers/runc/releases/download/v1.0.0-rc5/runc.amd64 -o /usr/local/sbin/runc && \
    chmod +x /usr/local/sbin/runc
ENTRYPOINT ["/usr/local/bin/dockerd"]
CMD ["-v"]
