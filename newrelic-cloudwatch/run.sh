#!/bin/bash
set -e
trap 'exit' SIGINT
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:-}
export AWS_SECRET_KEY=${AWS_SECRET_KEY:-}
export CMD={1:-}
export INTERVAL=${INTERVAL:-60}

function show_usage {
    echo "Usage: $0 <cmd> [command-args]"
}

if [ -z "$CMD" ] ; then
    show_usage
    exit 1
fi

case $1 in
    
    rpm)
        while [ 1 ]
        do
            OUT=`newrelic-rpm-check ${*:2} 2>&1 -s`
            arr=(${OUT//:/ })
            LENGTH=${#arr[@]}
            LAST_POS=$((LENGTH - 1))
            RPM=${arr[${LAST_POS}]}
            NAME=${arr[@]:1:$LAST_POS-1}
            NAMESPACE=`echo $NAME | sed 's/ //g'`
            echo "$NAME: $RPM rpm"
            mon-put-data -I $AWS_ACCESS_KEY_ID -S $AWS_SECRET_KEY -n \"Apps/$NAMESPACE\" --metric-name rpm -v $RPM -u Count
            sleep $INTERVAL
        done
        ;;

    *)
        echo "Unknown command $1"
        show_usage
        exit 1
        ;;
esac


