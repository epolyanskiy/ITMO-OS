#script6
#!/bin/bash

maxMem=0
maxPid=0

for pid in $(ls /proc | grep '^[0-9]\+$'); do
    if [[ -r "/proc/$pid/status" ]]; then
        mem=$(awk '/VmRSS/ {print $2}' /proc/$pid/status)
        if [[ -n "$mem" && "$mem" -gt "$max_mem" ]]; then
            maxMem=$mem
            maxPid=$pid
        fi
    fi
done

echo "PID: $maxPid, max mem: $maxMem KB"

top -b -o %MEM | head -n 1
