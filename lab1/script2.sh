#!/bin/bash

totalstring=""
currentstring=""

while true; do
read currentstring
if [[ "$currentstring" == "q" ]]; then
break
fi
totalstring="$totalstring $currentstring"
done

echo "Result: $totalstring"

