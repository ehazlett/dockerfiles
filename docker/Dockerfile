FROM golang:1.10 AS build
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl git build-essential libseccomp-dev btrfs-tools
WORKDIR /tmp
RUN mkdir /output
RUN git clone https://github.com/opencontainers/runc /go/src/github.com/opencontainers/runc && \
    cd /go/src/github.com/opencontainers/runc && make && mkdir /output/runc && cp runc /output/runc/
WORKDIR /tmp
RUN git clone https://github.com/containerd/containerd /go/src/github.com/containerd/containerd && \
    cd /go/src/github.com/containerd/containerd && make && mkdir /output/containerd && cp -rf bin/* /output/containerd/

FROM ubuntu:16.04
ARG VERSION
ARG DOCKER_URL
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl ca-certificates git iptables module-init-tools
RUN curl -sSL ${DOCKER_URL} -o /tmp/docker.tgz && \
    tar zxf /tmp/docker.tgz -C /tmp && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker*
RUN curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
COPY --from=build /output/containerd/* /usr/local/bin/
COPY --from=build /output/runc/* /usr/local/sbin/
ENTRYPOINT ["/usr/local/bin/dockerd"]
CMD ["-v"]
