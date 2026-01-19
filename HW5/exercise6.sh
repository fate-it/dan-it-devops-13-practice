#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage $0 \"<sentence>\""
    exit 1
fi

reversed=$(echo "$1" | tr ' ' '\n' | tac | tr '\n' ' ')
echo $reversed