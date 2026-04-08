#!/bin/bash

if [ ! -f "$1" ]; then
    echo "The source does not exist"
    exit 1
else
    cp $1 $2
fi

if [ $? -eq 0 ]; then
    echo "File copied successfully"
else
    echo "Error copied"
    exit 
fi
