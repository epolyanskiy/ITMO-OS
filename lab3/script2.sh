#!/bin/bash

echo "~/script1.sh" | at now + 2 minutes

tail -f ~/report &
disown
