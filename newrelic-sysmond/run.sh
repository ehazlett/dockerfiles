#!/bin/bash
if [ -z "$LICENSE_KEY" ]; then
    echo "ERR: you must set the LICENSE_KEY env var"
    exit 1
fi

CFG=/etc/newrelic/nrsysmond.cfg
echo "" > $CFG

if [ ! -z "$HOST_ROOT" ]; then
    echo "host_root=$HOST_ROOT" >> $CFG
fi

if [ ! -z "$NAME" ]; then
    echo "hostname=$NAME" >> $CFG
fi

echo "license_key=$LICENSE_KEY" >> $CFG

nrsysmond -F -c $CFG
