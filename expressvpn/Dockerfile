FROM debian:jessie
RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://download.expressvpn.xyz/clients/linux/expressvpn_1.2.0_amd64.deb -o /tmp/expressvpn.deb && \
    dpkg -i /tmp/expressvpn.deb && \
    apt-get -f -y install && \
    rm -rf /tmp/expressvpn.deb
