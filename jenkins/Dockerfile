FROM debian:jessie
ENV DOCKER_VERSION 1.9.1
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    wget \
    openjdk-7-jre-headless \
    git-core \
    unzip \
    apache2-utils \
    mercurial \
    subversion \
    build-essential
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update && \
    apt-get install -y jenkins && \
    mkdir -p /var/lib/jenkins/plugins
RUN (cd /var/lib/jenkins/plugins && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/cobertura.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/greenballs.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/instant-messaging.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/ircbot.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/postbuild-task.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/copy-to-slave.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/credentials.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/ssh-credentials.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/ssh-agent.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/git-client.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/git.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/github.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/github-api.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/scm-api.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/swarm.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/envinject.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/parameterized-trigger.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/token-macro.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/ghprb.hpi && \
    wget --no-check-certificate http://updates.jenkins-ci.org/latest/build-name-setter.hpi)
COPY config.xml /var/lib/jenkins/config.xml
ENV JENKINS_HOME /var/lib/jenkins
RUN wget --no-check-certificate https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION -O /usr/local/bin/docker && chmod +x /usr/local/bin/docker
RUN wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip -O /tmp/ec2tools.zip && \
    mkdir /usr/local/aws && unzip -d /usr/local/aws /tmp/ec2tools.zip && rm /tmp/ec2tools.zip && \
    mv /usr/local/aws/ec2-api-tools-* /usr/local/aws/ec2
ENV PATH $PATH:/usr/local/aws/ec2/bin
ENV EC2_HOME /usr/local/aws/ec2
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre
RUN wget https://storage.googleapis.com/golang/go1.4.1.linux-amd64.tar.gz -O /tmp/go.tar.gz && \
    tar -C /usr/local -xvf /tmp/go.tar.gz
ENV GOPATH /gocode
ENV PATH $PATH:/usr/local/go/bin:/gocode/bin
RUN go get github.com/tools/godep

RUN (git clone https://github.com/sstephenson/bats.git && \
    cd bats && ./install.sh /usr/local)

EXPOSE 8080
EXPOSE 8081
VOLUME /var/lib/jenkins
ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
CMD []
