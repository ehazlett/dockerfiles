#!/bin/bash
if [ -z "$LICENSE_KEY" ]; then
    echo "ERR: you must set the LICENSE_KEY env var"
    exit 1
fi

nrsysmond-config --set license_key=$LICENSE_KEY
nrsysmond -F -c /etc/newrelic/nrsysmond.cfg
