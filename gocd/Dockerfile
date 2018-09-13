FROM openjdk:8-jre
RUN apt-get update && apt-get install -y --no-install-recommends curl apt-transport-https git make ssh
RUN echo "deb https://download.gocd.org /" | tee /etc/apt/sources.list.d/gocd.list
RUN curl https://download.gocd.org/GOCD-GPG-KEY.asc | apt-key add - && apt-get update
RUN apt-get install -y go-server go-agent
RUN curl -sSL https://github.com/containerd/containerd/releases/download/v1.2.0-beta.2/containerd-1.2.0-beta.2.linux-amd64.tar.gz -o /tmp/containerd.tar.gz && \
    tar zxf /tmp/containerd.tar.gz --strip-components=1 -C /usr/local/bin/
COPY ssh_config /etc/ssh/ssh_config
