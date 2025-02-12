#!/bin/bash

logfile="$1"

grep "WARN" "$logfile" > 1.log
grep "ERROR" "$logfile" >> 1.log
