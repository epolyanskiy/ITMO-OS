#script2
#!/bin/bash

directoryPath="/sbin/"
outputFileName="outputScript2"

ps -eo pid,cmd | awk -v dir="$directoryPath" '$2 ~ "^" dir {print $1}' > "$outputFileName"
