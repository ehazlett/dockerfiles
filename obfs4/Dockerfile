FROM golang:1.6
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>
RUN echo "deb http://deb.torproject.org/torproject.org jessie main" > /etc/apt/sources.list.d/tor.list
ENV DEBIAN_FRONTEND noninteractive
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89 && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - && \
    apt-get update && \
    apt-get install -y \
        tor && \
    go get git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy && \
    cp $GOPATH/bin/obfs4proxy /usr/local/bin/obfs4proxy
    
COPY torrc /etc/tor/torrc
EXPOSE 443
CMD ["tor", "-f", "/etc/tor/torrc"]
