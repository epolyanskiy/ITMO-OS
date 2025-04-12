#!/bin/bash

home_dir="$HOME"
restore_dir="$home_dir/restore"

latest_backup=$(find "$home_dir" -maxdepth 1 -type d -name "Backup-*" | sort -r | head -n 1)

if [[ -z "$latest_backup" ]]; then
    echo "Backup search error!"
    exit 1
fi

mkdir -p "$restore_dir"

for file in "$latest_backup"/*; do
    filename=$(basename "$file")

    if [[ ! "$filename" =~ \.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        cp "$file" "$restore_dir/"
    fi
done

echo "Complete!"
