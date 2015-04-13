#!/bin/bash
UPSTREAMS=${1:-""}

show_usage() {
    echo "Usage: $0 [upstreams]"
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

    upstream up {
"

for UP in $UPSTREAMS; do
    echo "adding upstream $UP"
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
        }
    }
}
"

echo "$CONF" > /etc/nginx/nginx.conf

echo "proxy running"
exec nginx -c /etc/nginx/nginx.conf
