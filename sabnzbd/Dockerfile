FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends \
    sabnzbdplus unrar par2 python-yenc unzip python-openssl p7zip-full
EXPOSE 8080
CMD ["sabnzbdplus"]
