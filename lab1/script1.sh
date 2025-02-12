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
