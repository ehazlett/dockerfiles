FROM debian:jessie
MAINTAINER ejhazlett@gmail.com
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY unix$DISPLAY
RUN apt-get install -y --no-install-recommends \
    virt-manager \
    ssh \
    ssh-askpass-gnome
COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
