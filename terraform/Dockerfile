FROM alpine:latest
RUN apk add -U --no-cache curl unzip
RUN curl -sSL https://releases.hashicorp.com/terraform/0.10.6/terraform_0.10.6_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip -d /bin /tmp/terraform.zip && \
    rm -rf /tmp/terraform.zip
ENTRYPOINT ["/bin/terraform"]
CMD ["-h"]
