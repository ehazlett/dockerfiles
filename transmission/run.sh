#!/bin/ash
USER=${USER:-}
PASS=${PASS:-}
PORT=${PORT:-9091}
PEER_PORT=${PEER_PORT:-51413}
DOWNLOAD_DIR=${DOWNLOAD_DIR:-/downloads}

mkdir -p /etc/transmission /downloads
cat << EOF > /etc/transmission/settings.json
{
    "blocklist-enabled": 1,
    "blocklist-url": "http://john.bitsurge.net/public/biglist.p2p.gz",
    "download-dir": "$DOWNLOAD_DIR",
    "download-limit": 100,
    "download-limit-enabled": 0,
    "encryption": 1,
    "max-peers-global": 200,
    "peer-port": $PEER_PORT,
    "pex-enabled": 1,
    "port-forwarding-enabled": 0,
    "rpc-authentication-required": 1,
    "rpc-password": "$PASS",
    "rpc-port": $PORT,
    "rpc-username": "$USER",
    "rpc-enabled": 1,
    "rpc-bind-address": "0.0.0.0",
    "rpc-whitelist": "0.0.0.0/0",
    "rpc-whitelist-enabled": 0,
    "upload-limit": 100,
    "upload-limit-enabled": 0
}
EOF
transmission-daemon -f -g /etc/transmission $*
