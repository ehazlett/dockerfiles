FROM debian:jessie
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget && \
    wget https://s3.amazonaws.com/influxdb/influxdb_0.9.1_amd64.deb && \
    dpkg -i influxdb_0.9.1_amd64.deb && \
    apt-get -f -y install
COPY config /opt/influxdb/config
EXPOSE 8083 8086 8088
VOLUME /data
CMD ["/opt/influxdb/influxd", "run", "-config", "/opt/influxdb/config"]
