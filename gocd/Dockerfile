FROM openjdk:8-jre
RUN apt-get update && apt-get install -y --no-install-recommends curl apt-transport-https git make ssh bzr
RUN echo "deb https://download.gocd.org /" | tee /etc/apt/sources.list.d/gocd.list
RUN curl https://download.gocd.org/GOCD-GPG-KEY.asc | apt-key add - && apt-get update
RUN apt-get install -y go-server go-agent
RUN curl -sSL https://minio.home.evanhazlett.com/public/containerd-buildkit.tar.gz -o /tmp/package.tar.gz && \
    tar zxf /tmp/package.tar.gz --strip-components=1 -C / && \
    rm -rf /tmp/package.tar.gz
COPY ssh_config /etc/ssh/ssh_config
