FROM alpine:latest
RUN apk add -U curl bash
COPY run.sh /bin/run
COPY wait-for-it.sh /bin/wait-for-it.sh
ENTRYPOINT ["/bin/run"]
