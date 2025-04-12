#!/bin/bash

home_dir="$HOME"
source_dir="$home_dir/source"
report_file="$home_dir/backup-report"
current_date=$(date +%F)
backup_name="Backup-$current_date"
backup_dir="$home_dir/$backup_name"

latest_backup=$(find "$home_dir" -maxdepth 1 -type d -name "Backup-*" | sort -r | head -n 1)

if [[ -d "$latest_backup" ]]; then
    latest_date=$(basename "$latest_backup" | cut -d'-' -f2-)
    days_diff=$(( ( $(date -d "$current_date" +%s) - $(date -d "$latest_date" +%s) ) / 86400 ))
else
    days_diff=999
fi

if [[ $days_diff -ge 7 ]]; then
    mkdir "$backup_dir"

    cp "$source_dir"/* "$backup_dir"

    {
        echo "[$current_date] New backup file."
        echo
    } >> "$report_file"
else
    {
        echo "[$current_date] Update backup."
    } >> "$report_file"

    for file in "$source_dir"/*; do
        base_file=$(basename "$file")
        dest_file="$latest_backup/$base_file"

        if [[ ! -f "$dest_file" ]]; then
            cp "$file" "$dest_file"
            echo "New file: $base_file" >> "$report_file"
        else
            src_size=$(stat -c%s "$file")
            dst_size=$(stat -c%s "$dest_file")

            if [[ $src_size -ne $dst_size ]]; then
                mv "$dest_file" "$dest_file.$current_date"
                cp "$file" "$dest_file"
                echo "Update file: $base_file -> version: $base_file.$current_date" >> "$report_file"
            fi
        fi
    done

    echo >> "$report_file"
fi
