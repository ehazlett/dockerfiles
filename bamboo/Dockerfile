FROM openjdk:8-slim
RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-6.6.1.tar.gz -o /tmp/bamboo.tar.gz && \
    cd /opt && tar zxf /tmp/bamboo.tar.gz && \
    mv atlassian-bamboo* bamboo
COPY bamboo-init.properties /opt/bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
