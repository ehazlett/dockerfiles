#!/bin/bash
SSL_CA=${SSL_CA:-}
SSL_CERT=${SSL_CERT:-}
SSL_KEY=${SSL_KEY:-}

echo "Listening on $PORT"
if [ ! -z "$SSL_CA" ] && [ ! -z "$SSL_CERT" ] && [ ! -z "$SSL_KEY" ]; then
    echo "Using TLS"
    socat openssl-listen:$PORT,reuseaddr,cert=$SSL_CERT,key=$SSL_KEY,cafile=$SSL_CA,fork UNIX-CONNECT:/var/run/docker.sock
else
    socat TCP-LISTEN:$PORT,fork UNIX-CONNECT:/var/run/docker.sock
fi
