#!/bin/bash

current_day_by_weel=$(date +%u)

(crontab -l 2>/dev/null; echo "*/5 * * * $current_day_by_weel ~/script1.sh") | crontab -

echo "Task added"
crontab -l
