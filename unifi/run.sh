#!/bin/bash
/etc/init.d/unifi start

# wait for server start
until [ -e /var/log/unifi/server.log ]; do
    sleep 1
done

tail -f /var/log/unifi/*.log
