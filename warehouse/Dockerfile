FROM debian:jessie
RUN apt-get update && \
    apt-get install -y --no-install-recommends git-core openssh-server && \
    echo "$(which git-shell)" >> /etc/shells && \
    useradd -M -s $(which git-shell) git
COPY run.sh /usr/local/bin/run
