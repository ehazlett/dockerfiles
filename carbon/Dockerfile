FROM alpine:latest
RUN apk add -U --no-cache rsync bash py-pip py-setuptools ca-certificates curl
RUN pip install python-magic
ENV VERSION 1.6.1
RUN cd /tmp && \
    curl -sSL https://github.com/s3tools/s3cmd/releases/download/v${VERSION}/s3cmd-${VERSION}.tar.gz -o s3cmd-${VERSION}.tar.gz && \
    tar xzf s3cmd-${VERSION}.tar.gz && \
    cd s3cmd-${VERSION} && \
    python setup.py install && \
    rm -rf /var/cache/apk/* /tmp/s3cmd-${VERSION} /tmp/s3cmd-${VERSION}.tar.gz
ENTRYPOINT ["s3cmd"]
CMD ["-h"]
