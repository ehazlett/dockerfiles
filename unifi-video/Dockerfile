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
ENV VERSION 3.6.3
RUN curl -sSL https://dl.ubnt.com/firmwares/unifi-video/${VERSION}/unifi-video_${VERSION}~Debian7_amd64.deb -o /tmp/unifi-video.deb && \
    dpkg -i /tmp/unifi-video.deb && \
    apt-get -f -y install && \
    rm -rf /tmp/unifi-video.deb

