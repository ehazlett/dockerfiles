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
RUN mkdir -p /opt/minecraft && \
	echo "eula=true" > /opt/minecraft/eula.txt
RUN curl -sSL https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar -o /usr/local/bin/server.jar
ENV EULA true
EXPOSE 25565
WORKDIR /opt/minecraft
CMD ["java","-Xmx2G","-jar","/usr/local/bin/server.jar","nogui"]
