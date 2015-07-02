#!/bin/bash
echo "Listening on $PORT"
socat TCP-LISTEN:$PORT,fork UNIX-CONNECT:/var/run/docker.sock
