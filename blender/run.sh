#!/bin/bash
CONFIG=""
case "$1" in
    "manager")
        CONFIG=/master.blend
        ;;
    "worker")
        CONFIG=/worker.blend
        ;;
    *)
        echo "Usage: specify either 'manager' or 'worker' for the node role"
        exit 1
        ;;
esac

/opt/blender/blender --addons netrender -b -y $CONFIG -a -noaudio -nojoystick
