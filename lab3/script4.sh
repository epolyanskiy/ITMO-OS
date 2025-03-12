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
