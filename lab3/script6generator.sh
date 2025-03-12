#!/bin/bash

while [ ! -f processor.pid ]; do sleep 1; done
PROCESSOR_PID=$(cat processor.pid)

while true; do
    read INPUT

    case $INPUT in
        "+")
            kill -USR1 $PROCESSOR_PID
            ;;
        "*")
            kill -USR2 $PROCESSOR_PID
            ;;
        "TERM")
            kill -SIGTERM $PROCESSOR_PID
            rm -f processor.pid
            exit
            ;;
    esac
done
