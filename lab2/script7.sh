#script7
#!/bin/bash

outputFile="outputScript7"

declare -A beforeRead
declare -A afterRead

for pid in $(ls /proc | grep '^[0-9]\+$'); do
    if [[ -r "/proc/$pid/io" ]]; then
        beforeRead[$pid]=$(awk '/rchar/ {print $2}' /proc/$pid/io 2>/dev/null)
    fi
done

sleepTime=60
sleep $sleepTime

for pid in "${!beforeRead[@]}"; do
    if [[ -r "/proc/$pid/io" ]]; then
        afterRead[$pid]=$(awk '/rchar/ {print $2}' /proc/$pid/io 2>/dev/null)
    fi
done

echo -e "PID:CMD:READED_BYTES" > "$outputFile"
for pid in "${!beforeRead[@]}"; do
    if [[ -n ${afterRead[$pid]} ]]; then
        readDiff=$(( afterRead[$pid] - beforeRead[$pid] ))
        processCmd=$(ps -p $pid -o cmd --no-headers 2>/dev/null)
        echo -e "$pid:$processCmd:$readDiff"
    fi
done | sort -t ':' -k3 -nr | head -n 3 >> "$outputFile"
