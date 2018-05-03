FROM golang:1.10 as build
RUN go get -d github.com/coredns/coredns && \
    cd $GOPATH/src/github.com/coredns/coredns && \
    make coredns && cp $GOPATH/src/github.com/coredns/coredns/coredns /usr/local/bin/coredns

FROM alpine:3.6
COPY --from=build /usr/local/bin/coredns /usr/local/bin/
