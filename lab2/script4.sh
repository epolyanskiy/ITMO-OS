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
