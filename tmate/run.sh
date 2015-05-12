#!/bin/bash
SOCKET=/tmp/tmate.sock

show_usage() {
    echo "Usage:
    Make sure to mount the following volumes to get proper configs and keys:
    -v $HOME/.ssh:/home/dev/.ssh:ro

    The following are optional to use your own tmux and vim configs:

    -v $HOME/.tmux.conf:/home/dev/.tmux.conf:ro
    -v $HOME/.vim:/home/dev/.vim:ro
    "
    exit 1
}

# checks
if [ ! -e $HOME/.ssh ]; then
    show_usage
fi

tmate -S $SOCKET new-session -d

echo "Waiting for connection..."
tmate -S $SOCKET wait tmate-ready

ID=`tmate -S $SOCKET display -p '#{tmate_ssh}'`
ID_RO=`tmate -S $SOCKET display -p '#{tmate_ssh_ro}'`

echo "
Connection Info:

SSH: $ID
SSH Read only: $ID_RO
"

sleep infinity
