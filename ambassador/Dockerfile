FROM alpine:3.3
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>

RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

EXPOSE 8080
ENTRYPOINT ["/bin/run"]
ENV PORT 8080

COPY ambassador /bin/ambassador
COPY ./run /bin/run
