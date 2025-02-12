#script1
#!/bin/bash

x=$1
y=$2
z=$3

max=$x

if [[ $y -gt $max ]]; then
max=$y
fi
if [[ $z -gt $max ]]; then
max=$z
fi

echo "max: $max"

#script2
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

#script3
#!/bin/bash

while true; do

echo "Menu:"
echo "1) Nano"
echo "2) Vi"
echo "3) Links"
echo "4) EXIT"
echo ""
echo "Choice:"

read choice

case $choice in
1) nano
;;
2) vi
;;
3) links
;;
4) break
;;
esac

done

#script4
#!/bin/bash

currentdirectory=$(pwd)

if [[ "$currentdirtectory" == "$HOME" ]]; then
echo "Home directory: $HOME"
exit 0
else
echo "ERROR! Home directory: $HOME"
exit 1
fi

#script5-6
#!/bin/bash

logfile="$1"

grep "WARN" "$logfile" > 1.log
grep "ERROR" "$logfile" >> 1.log

#script7
#!/bin/bash

grep -Eroh "[a-zA-Z0-9._]+@[a-zA-Z0-9._]+\.[a-zA-Z]{2,}" etc > emails.lst

#script8
#!/bin/bash

cut -d: -f1,3 /etc/passwd | sort -t: -k2 -n

#script9
#!/bin /bash 

totalcounter=0

wc -l /var/log/*.log | tail -n1

#script10
#!/bin/bash

man bash | tr -cs '[:alnum:]' '[\n*]' | awk 'length($0) >= 4' | sort | uniq -c | sort -nr | head -n 3
