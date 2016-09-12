FROM ubuntu:16.04
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list && \
    echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    sabnzbdplus unrar par2 python-yenc unzip python-openssl
EXPOSE 8080
CMD ["sabnzbdplus"]
