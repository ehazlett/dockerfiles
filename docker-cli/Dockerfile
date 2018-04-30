FROM alpine:3.6 as build
ARG DOCKER_VERSION=18.04.0-ce
RUN apk add -U curl ca-certificates
RUN curl -o /tmp/docker.tar.gz https://download.docker.com/linux/static/edge/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar zxf /tmp/docker.tar.gz --strip-components=1 -C /usr/local/bin

FROM scratch
COPY --from=build /usr/local/bin/docker /bin/docker
