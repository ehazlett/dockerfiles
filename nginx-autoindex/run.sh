#!/bin/bash
ROOT_DIR=${ROOT_DIR:-/usr/share/nginx/html}
sed -i 's@ROOT_PLACEHOLDER@'"$ROOT_DIR"'@' /etc/nginx/nginx.conf
nginx -g "daemon off;" -c /etc/nginx/nginx.conf
