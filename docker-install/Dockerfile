FROM scratch
COPY scripts /bin/scripts
COPY docker-install /bin/docker-install
EXPOSE 8080
WORKDIR /bin
ENTRYPOINT ["/bin/docker-install"]
