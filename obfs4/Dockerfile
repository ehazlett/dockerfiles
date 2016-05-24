FROM alpine:latest
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/testing tor && \
    rm -rf /var/cache/apk/* 
COPY obfs4proxy /usr/local/bin/obfs4proxy
COPY torrc /etc/tor/torrc
EXPOSE 443
CMD ["tor", "-f", "/etc/tor/torrc"]
