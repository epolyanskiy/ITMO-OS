#!/bin/bash

directory="$1"
previousFiles=""

while true; do
    if [[ -d "$directory" ]]; then
        currentFiles=$(ls -A "$directory" 2>/dev/null)

        for file in $currentFiles; do
            if [[ ! "$previousFiles" =~ "$file" ]]; then
                echo "$directory/$file" > new_files_info
            fi
        done

        previousFiles="$currentFiles"
    fi
    sleep 5
done
