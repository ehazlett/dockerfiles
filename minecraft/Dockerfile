FROM openjdk:8u131-jre-alpine
RUN apk add -U \
          openssl \
          imagemagick \
          lsof \
          su-exec \
          bash \
          curl iputils wget \
          git \
          jq \
          mysql-client \
        rm -rf /var/cache/apk/*
ENV EULA true
COPY run /bin
EXPOSE 25565
VOLUME ["/data"]
CMD ["/bin/run"]
