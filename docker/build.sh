#!/bin/bash
set -e
VERSIONS=${VERSIONS:-"17.06.2-ce 17.09.0-ce 18.02.0-ce 18.03.0-ce 18.06.1-ce"}
DEFAULT_BASE="https://download.docker.com/linux/static/edge/x86_64"

for ver in $VERSIONS; do
    echo " -> Building ${ver}"
    base=$DEFAULT_BASE
    if [[ "$ver" == *"rc"* ]] || [[ "$ver" == *"beta"* ]] || [[ "$ver" == *"tp"* ]]; then
	    base="https://download.docker.com/linux/static/test/x86_64"
    fi
    docker build -t ehazlett/docker:${ver} --build-arg VERSION=${ver} --build-arg DOCKER_URL="${base}/docker-${ver}.tgz" .
    docker push ehazlett/docker:${ver}
done
