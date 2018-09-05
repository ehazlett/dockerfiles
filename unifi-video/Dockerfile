FROM debian:jessie
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
        curl \
        psmisc \
        lsb-release \
        mongodb-server \
        default-jre-headless \
        jsvc
ENV VERSION 3.9.8
RUN curl -sSL https://dl.ubnt.com/firmwares/ufv/v${VERSION}/unifi-video.Debian7_amd64.v${VERSION}.deb -o /tmp/unifi-video.deb && \
    dpkg -i /tmp/unifi-video.deb && \
    apt-get -f -y install && \
    rm -rf /tmp/unifi-video.deb
COPY run.sh /usr/local/bin/run
CMD ["/usr/local/bin/run"]
