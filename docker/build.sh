#!/bin/bash
set -e
VERSIONS="17.06.2-ce 17.09.0-ce"

for ver in $VERSIONS; do
    echo " -> Building ${ver}"
    docker build -t ehazlett/docker:${ver} --build-arg VERSION=${ver} .
    docker push ehazlett/docker:${ver}
done
