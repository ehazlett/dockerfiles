FROM alpine
RUN apk --update add go git
ENV GOPATH /go
RUN go get -u github.com/cloudflare/cfssl/cmd/...
