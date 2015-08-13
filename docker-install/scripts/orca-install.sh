#!/bin/bash

# Usage:
#  bash <(curl -sL http://docker-install.evanhazlett.com/orca) -h

docker run --rm -ti \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name orca-bootstrap dockerorca/orca-bootstrap \
    $*
