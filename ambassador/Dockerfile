FROM alpine:latest
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>

RUN apk add -U bash ca-certificates && rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/ambassador"]
CMD ["-h"]

COPY ambassador /bin/ambassador
