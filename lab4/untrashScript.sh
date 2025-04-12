#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Argument error!"
    exit 1
fi

file_name="$1"
trash_dir="$HOME/trash"
log_file="$HOME/trash.log"

if [ ! -f "$log_file" ]; then
    echo "Log file error!"
    exit 2
fi

matches=$(grep "/.*/$file_name ->" "$log_file")

if [ -z "$matches" ]; then
    echo "File search error!"
    exit 0
fi

IFS=$'\n'
for line in $matches; do
    path=$(echo "$line" | cut -d' ' -f1)
    number=$(echo "$line" | awk '{print $3}')

    echo "File found: $path"
    read -p "Rollback? [y/N]: " answer

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        directory=$(dirname "$path")

        if [ -d "$directory" ]; then
            new_path="$path"
        else
            echo "Directory error! Rolling back to home."
            new_path="$HOME/$file_name"
        fi

        if [ -e "$new_path" ]; then
            read -p "File name conflict. Input new file name: " new_name
            new_path="$directory/$new_name"
        fi

        ln "$trash_dir/$number" "$new_path" && rm "$trash_dir/$number"

        grep -vF "$line" "$log_file" > "$log_file.tmp" && mv "$log_file.tmp" "$log_file"

        echo "Rollback complete!"
    fi
done
