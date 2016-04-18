#!/bin/bash
UPSTREAMS=${1:-""}
WEBSOCKET_ENDPOINTS=${WEBSOCKET_ENDPOINTS:-""}
AUTH_USER=${AUTH_USER:-}
AUTH_PASS=${AUTH_PASS:-}
AUTH_REALM=${AUTH_REALM:-Private}

show_usage() {
    echo "Usage: $0 [upstreams]
    The following environment variables are available
    for customization of the backend:

    WEBSOCKET_ENDPOINTS: space separated list of Websocket endpoints to upgrade
    "
}

if [ -z "$UPSTREAMS" ]; then
    show_usage
    exit 1
fi

echo "configuring proxy"

CONF="
user  nginx;
worker_processes  1;
daemon off;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    client_max_body_size 2048M;

"

if [ ! -z "$WEBSOCKET_ENDPOINTS" ]; then
    CONF="$CONF
    map \$http_upgrade \$connection_upgrade {
        default upgrade;
        ''      close;
}
"
fi

CONF="$CONF
    upstream up {
"
for UP in $UPSTREAMS; do
    echo "adding upstream: $UP"
    CONF="$CONF
        server $UP;
"
done
    CONF="$CONF
    }

    log_format  main  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
                      '\$status \$body_bytes_sent \"\$http_referer\" '
                      '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

"

CONF="$CONF
    server {
        listen 80;
        location / {
            proxy_pass http://up;
            proxy_connect_timeout       600;
            proxy_send_timeout          600;
            proxy_read_timeout          600;
            send_timeout                600;
"

# authorization
if [ ! -z "$AUTH_USER" ] && [ ! -z "$AUTH_PASS" ]; then
    echo "configuring authorization"
    htpasswd -b -c /etc/nginx.users "$AUTH_USER" "$AUTH_PASS"
    CONF="$CONF
            auth_basic \"$AUTH_REALM\";
            auth_basic_user_file /etc/nginx.users;
"
fi

CONF="$CONF
        }
"
for WS in $WEBSOCKET_ENDPOINTS; do
    echo "adding websocket endpoint: $WS"
    CONF="$CONF
    location $WS {
        proxy_pass http://up;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \"upgrade\";
    }
"
done

CONF="$CONF
    }
}
"

echo "$CONF" > /etc/nginx/nginx.conf

echo "proxy running"
exec nginx -c /etc/nginx/nginx.conf
