#!/bin/bash

currentdirectory=$(pwd)

if [[ "$currentdirtectory" == "$HOME" ]]; then
echo "Home directory: $HOME"
exit 0
else
echo "ERROR! Home directory: $HOME"
exit 1
fi

