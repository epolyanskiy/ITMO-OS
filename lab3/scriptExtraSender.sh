#!/bin/bash

mkfifo directory_requests 2>/dev/null
mkfifo new_files_info 2>/dev/null

declare -A knownFiles

echo "Input name of new directory: "
read directoryName
echo "$directoryName" > directory_requests

while true; do
    if read line < new_files_info; then
        timestamp=$(date +%Y-%m-%d_%H:%M:%S)
        echo "[$timestamp] $line"
    fi

    sleep 10
    echo "[INFO] No updates..."
done
