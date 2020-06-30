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
ENV MINECRAFT_URL https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar
RUN curl -sSL $MINECRAFT_URL -o /usr/local/bin/server.jar
ENV EULA true
EXPOSE 25565
WORKDIR /opt/minecraft
CMD ["java","-Xmx2G","-jar","/usr/local/bin/server.jar","nogui"]
