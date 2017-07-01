FROM alpine:latest
ENV VERSION 17.06.0-ce
RUN apk add -U curl git iptables && \
    curl -sSL https://download.docker.com/linux/static/edge/x86_64/docker-${VERSION}.tgz -o /tmp/docker.tgz && \
    tar zxf /tmp/docker.tgz -C /tmp && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker*
ENTRYPOINT ["/usr/local/bin/dockerd"]
CMD ["-v"]
