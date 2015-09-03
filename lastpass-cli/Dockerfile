FROM debian:jessie
RUN apt-get update && apt-get install -y --no-install-recommends lastpass-cli && \
    rm -rf /var/lib/apt/lists/*
ENTRYPOINT "/usr/bin/lpass"
