#!/bin/sh
HOST=${HOST:-}
UPSTREAMS=${UPSTREAMS:-}
CONFIG=${CONFIG:-"/etc/caddyfile"}
CADDY_ARGS=${CADDY_ARGS:-}

cat << EOF > $CONFIG
${HOST} {
    proxy / {
        transparent
EOF
for up in $UPSTREAMS; do
    cat << EOF >> $CONFIG
        upstream $up
EOF
done

cat << EOF >> $CONFIG
    }
}
EOF

exec caddy -conf ${CONFIG} ${CADDY_ARGS}
