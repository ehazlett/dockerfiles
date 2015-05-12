FROM ubuntu:14.04
RUN echo "deb http://ppa.launchpad.net/nviennot/tmate/ubuntu trusty main" >> /etc/apt/sources.list.d/tmate.list
#RUN echo "deb-src http://ppa.launchpad.net/nviennot/tmate/ubuntu trusty main" >> /etc/apt/sources.list.d/tmate.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3EBC003
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends tmate vim git-core openssh-client sudo
COPY run.sh /usr/local/bin/run
RUN useradd dev && \
    mkdir -p /home/dev && \
    chown -R dev:dev /home/dev && \
    usermod -s /bin/bash dev && \
    usermod -aG sudo dev

RUN echo "dev:dev | chpasswd"
WORKDIR /home/dev

USER dev

EXPOSE 22

CMD ["/usr/local/bin/run"]
