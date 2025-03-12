#!/bin/bash

[ ! -p pipe ] && mkfifo pipe

MODE="+"
RESULT=1

tail -f pipe | while true; do
    read LINE
    case $LINE in
        "+")
            MODE="+"
            ;;
        "*")
            MODE="*"
            ;;
        "QUIT")
            echo "end"
            rm pipe
            exit
            ;;
        [0-9]*)
            if [ "$MODE" == "+" ]; then
                RESULT=$((RESULT + LINE))
            else
                RESULT=$((RESULT * LINE))
            fi
            echo "Result: $RESULT"
            ;;
        *)
            echo "Error"
            exit 1
            ;;
    esac
done
