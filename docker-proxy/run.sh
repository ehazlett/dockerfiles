#!/bin/bash
SSL_CA=${SSL_CA:-}
SSL_CERT=${SSL_CERT:-}
SSL_KEY=${SSL_KEY:-}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage:"
    echo "  By default, it will bind mount to the Docker socket"
    echo "  To enable TLS, pass the SSL_CA, SSL_CERT and SSL_KEY environment"
    echo "  variables to the paths of the certificates."
    exit 1
fi

echo "Listening on $PORT"
if [ ! -z "$SSL_CA" ] && [ ! -z "$SSL_CERT" ] && [ ! -z "$SSL_KEY" ]; then
    echo "Using TLS"
    socat openssl-listen:$PORT,reuseaddr,cert=$SSL_CERT,key=$SSL_KEY,cafile=$SSL_CA,fork UNIX-CONNECT:/var/run/docker.sock
else
    socat TCP-LISTEN:$PORT,fork UNIX-CONNECT:/var/run/docker.sock
fi
