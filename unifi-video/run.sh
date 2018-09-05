#!/bin/bash
DATA_DIR=${DATA_DIR:-"/var/lib/unifi-video"}
mkdir -p ${DATA_DIR}/{videos,logs,db}

chown -R unifi-video ${DATA_DIR}
chmod -R g+rw ${DATA_DIR}

exec unifi-video -D start
