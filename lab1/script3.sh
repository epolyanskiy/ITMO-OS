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
