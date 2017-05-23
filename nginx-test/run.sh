#!/bin/ash
echo "${CONTENT}" > /usr/share/nginx/html/index.html
nginx -g "daemon off;"
