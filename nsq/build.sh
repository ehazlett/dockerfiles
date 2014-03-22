#!/bin/bash
TAG=$1

if [ -z "$TAG" ] ; then
    echo "Usage: $0 <tag-name>"
    exit 1
fi

if [ ! -e "nsq.tar.gz" ] ; then
    wget https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.2.27.linux-amd64.go1.2.tar.gz -O nsq.tar.gz
    tar zxf nsq.tar.gz
    mv nsq-* nsq
fi
docker build -t $TAG .

