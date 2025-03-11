#script1
#!/bin/bash

userName="egor"
outputFileName="outputScript1"

numberOfHeaderLines=1
processCounter=$(($(ps -u "$userName" | wc -l)-$numberOfHeaderLines))

echo "Number of processes by $userName: $processCounter" > "$outputFileName"

ps -u "$userName" -o pid,cmd | awk '{print $1":"$2}' >> "$outputFileName"
