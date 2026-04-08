#!/bin/bash

if [ ! -f "./$1" ]; then
    echo "The file $1 does not exist"
    exit 1
fi

echo $(wc -l < "./$1")
