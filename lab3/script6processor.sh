#!/bin/bash

echo $$ > processor.pid

RESULT=1
MODE="wait"

handle_usr1() {
    MODE="+"
}

handle_usr2() {
    MODE="*"
}

handle_sigterm() {
    echo "end"
    rm -f processor.pid
    exit
}

trap 'handle_usr1' USR1
trap 'handle_usr2' USR2
trap 'handle_sigterm' SIGTERM

while true; do
    sleep 1
    if [[ "$MODE" == "wait" ]]; then
        continue
    elif [[ "$MODE" == "+" ]]; then
        RESULT=$((RESULT + 2))
    else
        RESULT=$((RESULT * 2))
    fi
    echo "result: $RESULT"
done
