FROM debian:sid
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 \
    dirmngr
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" > /etc/apt/sources.list.d/ubnt.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    apt-get update

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        unifi
COPY run.sh /usr/local/bin/run
EXPOSE 8443
CMD ["/usr/local/bin/run"]
