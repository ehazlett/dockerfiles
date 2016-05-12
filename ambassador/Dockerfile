FROM alpine:latest
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>

RUN apk add -U bash ca-certificates && rm -rf /var/cache/apk/*

EXPOSE 8080
ENTRYPOINT ["/bin/ambassador"]
CMD ["-h"]
ENV PORT 8080

COPY ambassador /bin/ambassador
