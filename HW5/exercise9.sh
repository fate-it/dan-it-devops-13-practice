#!/bin/bash


if [ -z "$1" ] ; then
    echo "Usage: $0 <file>"
    exit 1
fi 


if [ ! -r "$1" ]; then
    echo "File is not exist or not readable"
    exit 2
fi

cat $1