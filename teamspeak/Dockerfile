FROM stackbrew/debian:jessie
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>
RUN apt-get update
RUN apt-get install -y wget
RUN wget http://dl.4players.de/ts/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz -O /tmp/teamspeak.tar.gz && tar zxf /tmp/teamspeak.tar.gz -C /opt && mv /opt/teamspeak3-server_* /opt/teamspeak
EXPOSE 9987/udp 10011 30033
VOLUME /opt/teamspeak
CMD ["/opt/teamspeak/ts3server_minimal_runscript.sh"]

