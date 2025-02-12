#!/bin/bash

grep -Eroh "[a-zA-Z0-9._]+@[a-zA-Z0-9._]+\.[a-zA-Z]{2,}" etc > emails.lst
