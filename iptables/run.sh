#!/bin/bash
#
CONFIG="${CONFIG:-/iptables.rules}"

if [ -z "${CONFIG}" ]; then
    echo "Usage: docker run -v /path/to/iptables.rules:/iptables.rules ehazlett/iptables"
    exit 1
fi

# check for config
if [ ! -e "${CONFIG}" ]; then
    echo "ERR: unable to find the configuration at ${CONFIG}"
    exit 1
fi

# check for caps
iptables -L > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERR: you must run this container with capability NET_ADMIN (--cap-add NET_ADMIN)"
    exit 1
fi

# check for net=host
ip a s docker0 > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERR: you must run this container with net=host"
    exit 1
fi

iptables-restore < ${CONFIG}

iptables -L
