FROM ubuntu:16.04
ARG VERSION
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl ca-certificates git iptables module-init-tools && \
    curl -sSL https://download.docker.com/linux/static/edge/x86_64/docker-${VERSION}.tgz -o /tmp/docker.tgz && \
    tar zxf /tmp/docker.tgz -C /tmp && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker*
ENTRYPOINT ["/usr/local/bin/dockerd"]
CMD ["-v"]
