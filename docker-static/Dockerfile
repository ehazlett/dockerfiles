FROM alpine:latest as build
RUN apk add -U curl ca-certificates
RUN curl -sSL https://download.docker.com/linux/static/nightly/x86_64/docker-0.0.0-20180807170338-5f75afe.tgz -o /var/tmp/docker.tgz && \
    cd /var/tmp && tar zxf docker.tgz

FROM scratch
COPY --from=build /var/tmp/docker/* /bin/
