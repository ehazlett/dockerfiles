FROM alpine:latest
RUN apk add -U python py-pip groff && \
    pip install awscli
ENTRYPOINT ["/usr/bin/aws"]
CMD ["help"]
