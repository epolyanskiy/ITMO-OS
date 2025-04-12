#!/bin/bash

mkfifo directory_requests 2>/dev/null
mkfifo new_files_info 2>/dev/null

while true; do
    if read directoryName < directory_requests; then
        mkdir -p "$directoryName"
        echo "[receiver] New directory: $directoryName"

        ./scriptExtraWatcher.sh "$directoryName" &
    fi
done
