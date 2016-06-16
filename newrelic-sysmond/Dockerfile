FROM ubuntu:14.04
RUN apt-get update && apt-get install -y curl && \
    curl -sSL https://download.newrelic.com/debian/dists/newrelic/non-free/binary-amd64/newrelic-sysmond_2.3.0.132_amd64.deb -o /tmp/newrelic.deb && \
    dpkg -i /tmp/newrelic.deb && \
    apt-get -f -y install && \
    rm -rf /tmp/*
COPY run.sh /bin/run
CMD ["/bin/run"]
