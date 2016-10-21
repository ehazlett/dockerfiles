#!/bin/bash
BASE_DIR=/p
chmod 700 $BASE_DIR/.ssh/authorized_keys

function init() {
    usermod -d $BASE_DIR git

    # copy host keys to persist
    mkdir -p $BASE_DIR/.keys

    for key in $(ls /etc/ssh/ssh_host_*); do
        if [ ! -e $BASE_DIR/$(basename $key) ]; then
            cp $key $BASE_DIR/$(basename $key)
        fi
    done

    for project in $(cat $BASE_DIR/.projects); do
        if [ ! -e "$BASE_DIR/$project" ]; then
            echo "initializing repository: $project"
            mkdir -p $BASE_DIR/$project
            ln -sf $BASE_DIR/$project $BASE_DIR/$project.git
            pushd $BASE_DIR/$project > /dev/null
            git init --bare
            popd > /dev/null
        fi
    done

    chown -R git:git $BASE_DIR

    mkdir -p /var/run/sshd
    /usr/sbin/sshd -D -E $BASE_DIR/sshd.log
}

trap init SIGHUP SIGINT

