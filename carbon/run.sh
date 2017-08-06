#!/bin/bash

SOURCE=$2
DEST=$3

case "$1" in
    "backup")
        echo ":: backing up $SOURCE -> $DEST"
        ;;
    "restore")
        echo ":: restoring $SOURCE -> $DEST"
        ;;
    *)
        echo "Usage: <backup|restore> <source> <dest>"
        exit 1
        ;;
esac
