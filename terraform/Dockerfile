FROM alpine:latest as build
RUN apk add -U --no-cache curl unzip
RUN curl -sSL https://releases.hashicorp.com/terraform/0.10.6/terraform_0.10.6_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip -d /tmp /tmp/terraform.zip

FROM alpine:latest
COPY --from=build /tmp/terraform /bin/terraform
ENTRYPOINT ["/bin/terraform"]
CMD ["-h"]
