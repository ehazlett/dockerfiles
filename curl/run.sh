#!/bin/ash
curl $@

if [ ! -z "${LOOP}" ]; then
    while true; do
        curl $@
        sleep 1
    done
fi
