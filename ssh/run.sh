#!/bin/bash
SSH_USER=${SSH_USER:-user}
SSH_KEY=${SSH_KEY:-}
HOME_DIR=/home/$SSH_USER

# create user
echo "creating user $SSH_USER"
mkdir -p $HOME_DIR
adduser -S -s /bin/bash -D $SSH_USER -h $HOME_DIR
chown -R $SSH_USER $HOME_DIR
passwd -u $SSH_USER

if [ -z "${SSH_KEY}" ]; then
    echo "You must specify an SSH public key via the SSH_KEY env var"
    exit 1
fi

echo "injecting ssh key"
mkdir -p $HOME_DIR/.ssh
echo "$SSH_KEY" > $HOME_DIR/.ssh/authorized_keys

ssh-keygen -A

echo "starting ssh server"
/usr/sbin/sshd -D -f /etc/ssh/sshd_config
