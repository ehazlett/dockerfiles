FROM debian:jessie
RUN apt-get update && \
    apt-get install -y --no-install-recommends git-core openssh-server && \
    echo "$(which git-shell)" >> /etc/shells && \
    useradd -M -s $(which git-shell) git && \
    sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd
COPY run.sh /usr/local/bin/run
