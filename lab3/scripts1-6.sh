#script1

#!/bin/bash

mkdir ~/test && echo "catalog test was created successfully" >> ~/report && touch ~/test/$(date +%Y-%m-%d_%H-%M-%S)

ping -c1 www.net_nikogo.ru > /dev/null 2>&1 || echo "$(date +%Y-%m-%d_%H-%M-%S) Error: host unavaliable" >> ~/report

#script2

#!/bin/bash

echo "~/script1.sh" | at now + 2 minutes

tail -f ~/report &
disown

#script3

#!/bin/bash

current_day_by_weel=$(date +%u)

(crontab -l 2>/dev/null; echo "*/5 * * * $current_day_by_weel ~/script1.sh") | crontab -

echo "Task added"
crontab -l

#script4

#!/bin/bash

(while true; do echo $((2*2)) > /dev/null; done) &
PID1=$!
(while true; do echo $((3*3)) > /dev/null; done) &
PID2=$!
(while true; do echo $((4*4)) > /dev/null; done) &
PID3=$!

echo "Processes: $PID1, $PID2, $PID3"

sleep 3

top -b -n1 | grep "$PID1\|$PID2\|$PID3"

renice 10 -p $PID1

kill $PID3
echo "Kill process $PID3"

sleep 3
top -b -n1 | grep "$PID1\|$PID2"

#script5

#gen

#!/bin/bash

mkfifo pipe 2>/dev/null

while true; do
    read INPUT
    echo "$INPUT" > pipe
    [ "$INPUT" == "QUIT" ] && break
done

#proc

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

#script6

#gen

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

#proc

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
    if [[ "$MODE" == "ожидание" ]]; then
        continue
    elif [[ "$MODE" == "сложение" ]]; then
        RESULT=$((RESULT + 2))
    else
        RESULT=$((RESULT * 2))
    fi
    echo "result: $RESULT"
done


