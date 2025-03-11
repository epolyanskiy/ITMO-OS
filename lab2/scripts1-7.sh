#script1
#!/bin/bash

userName="egor"
outputFileName="outputScript1"

numberOfHeaderLines=1
processCounter=$(($(ps -u "$userName" | wc -l)-$numberOfHeaderLines))

echo "Number of processes by $userName: $processCounter" > "$outputFileName"

ps -u "$userName" -o pid,cmd | awk '{print $1":"$2}' >> "$outputFileName"

#script2
#!/bin/bash

directoryPath="/sbin/"
outputFileName="outputScript2"

ps -eo pid,cmd | awk -v dir="$directoryPath" '$2 ~ "^" dir {print $1}' > "$outputFileName"

#script3
#!/bin/bash

ps -eo pid,lstart --sort=start_time | tail -n 1 | awk '{print $1}'

#script4
#!/bin/bash

outputFileName="outputScript4"

for pid in $(ls /proc | grep '^[0-9]\+$'); do
	ppid=$(awk '{print $4}' /proc/$pid/stat 2>/dev/null)
        sum_exec_runtime=$(awk '/se.sum_exec_runtime/ {print $3}' /proc/$pid/sched 2>/dev/null)
        nr_switches=$(awk '/nr_switches/ {print $3}' /proc/$pid/sched 2>/dev/null)
        if [[ "$nr_switches" -gt 0 ]]; then
            avg_runtime=$(echo "scale=3; $sum_exec_runtime / $nr_switches" | bc)
            echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$avg_runtime" >> "$outputFileName"
        fi
done

sort -t '=' -k 2 -n "$outputFileName" -o "$outputFileName"c

#script5
#!/bin/bash

inputFileName="outputScript4"
outputFileName="outputScript5"

awk -F '[=:]' '
{
    gsub(" ", "", $4);
    gsub(" ", "", $6);
    parent[$4] += $6;
    count[$4]++;
}
END {
    for (p in parent) {
        avg = parent[p] / count[p];
        print "Average_Running_Children_of_ParentID=" p " is " avg;
    }
}' "$inputFileName" > "$outputFileName"

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
