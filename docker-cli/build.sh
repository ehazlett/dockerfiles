#!/bin/bash
VERSIONS="17.12.1-ce 18.03.0-ce 18.03.1-ce 18.04.0-ce"

for VER in $VERSIONS; do
    docker build -t ehazlett/docker-cli:${VER} --build-arg DOCKER_VERSION=$VER .
    docker push ehazlett/docker-cli:${VER}
done
