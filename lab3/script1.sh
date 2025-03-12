#!/bin/bash

mkdir ~/test && echo "catalog test was created successfully" >> ~/report && touch ~/test/$(date +%Y-%m-%d_%H-%M-%S)

ping -c1 www.net_nikogo.ru > /dev/null 2>&1 || echo "$(date +%Y-%m-%d_%H-%M-%S) Error: host unavaliable" >> ~/report
