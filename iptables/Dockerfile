FROM alpine:latest
RUN apk add -U --no-cache iptables bash
COPY run.sh /usr/local/sbin/run
ENTRYPOINT ["/usr/local/sbin/run"]
