FROM debian:jessie
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    echo "deb http://download.rethinkdb.com/apt jessie main" | tee /etc/apt/sources.list.d/rethinkdb.list && \
    wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends rethinkdb && \
    apt-get -y clean
COPY run.sh /usr/local/bin/run
EXPOSE 8080
EXPOSE 28015
EXPOSE 29015
CMD ["/usr/local/bin/run"]
