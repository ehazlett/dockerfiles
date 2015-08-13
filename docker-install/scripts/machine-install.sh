#!/bin/bash
set -e
# 
# Usage:
#  curl -sL https://docker-install.evanhazlett.com/machine | sudo bash -s
#
# Options:
# Pass the follwing as environment variables
#
#   INSTALL_PATH: dest path for binary; default: /usr/local/bin/docker-machine
#   VERSION: override version for install; default: latest release
#
# Example:
#   curl -sSL https://docker-install.evanhazlett.com/machine | sudo VERSION=v0.4.0 INSTALL_PATH=/tmp/docker-machine bash -s

SYS_NAME=$(uname -s)
SYS_ARCH=$(uname -m)
INSTALL_PATH=${INSTALL_PATH:-/usr/local/bin/docker-machine}
VERSION=${VERSION:-}
# machine vars
OS=""
ARCH=""
BINARY=""

case $SYS_NAME in
    Linux*)
        OS=linux
        ;;
    MING*)
        OS=windows
        ;;
    Darwin*)
        OS=darwin
        ;;
    *)
        echo "Unknown OS"
        exit 1
esac

case $SYS_ARCH in
    *64)
        ARCH="amd64"
        ;;
    *)
        ARCH="386"
        ;;
esac

BINARY=docker-machine_$OS-$ARCH
if [ $OS = "windows" ]; then
    BINARY=docker-machine_$OS-$ARCH.exe
fi

if [ -z "$VERSION" ]; then
    VERSION=$(curl -sL https://api.github.com/repos/docker/machine/releases/latest | grep tag_name | awk -F: '{ print $2;  }' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g')
fi

BINARY_LINK=https://github.com/docker/machine/releases/download/$VERSION/$BINARY
MD5_SUM_LINK=$BINARY_LINK.md5

echo "Downloading Machine $VERSION for $OS"

MD5=$(curl -sSL $MD5_SUM_LINK | awk '{ print $1; }')
curl -sSL $BINARY_LINK -o $INSTALL_PATH

# check md5
BINARY_SUM=$(md5sum $INSTALL_PATH | awk '{ print $1; }')

if [ "$BINARY_SUM" != "$MD5" ]; then
    echo "Invalid MD5: $BINARY_SUM"
    echo "Expected: $MD5"
    rm $INSTALL_PATH
    exit 1
fi

echo "Checksum verified"

chmod +x $INSTALL_PATH

echo "Docker Machine $VERSION installed successfully"

