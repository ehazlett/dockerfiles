FROM alpine:latest
RUN apk add --no-cache ca-certificates && update-ca-certificates && \
    wget -O /microscanner https://get.aquasec.com/microscanner && \
    chmod +x /microscanner
