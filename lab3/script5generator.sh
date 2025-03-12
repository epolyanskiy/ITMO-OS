#!/bin/bash

mkfifo pipe 2>/dev/null

while true; do
    read INPUT
    echo "$INPUT" > pipe
    [ "$INPUT" == "QUIT" ] && break
done
