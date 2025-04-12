#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Argument error!"
    exit 1
fi

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "File error!"
    exit 2
fi

trash_dir="$HOME/trash"
log_file="$HOME/trash.log"

if [ ! -d "$trash_dir" ]; then
    mkdir "$trash_dir" || { echo "Trash directory error!"; exit 3; }
fi

current_number=1
while [ -e "$trash_dir/$current_number" ]; do
    ((current_number=current_number+1))
done

ln -- "$file_name" "$trash_dir/$current_number" || {
    echo "Link error!"
    exit 4
}

path="$(readlink -f "$file_name")"

rm -- "$file_name" || {
    echo "File delete error!"
    exit 5
}

echo "$path -> $current_number" >> "$log_file"

echo "Success!"
