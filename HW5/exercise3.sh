#!/bin/bash
if [ -f "./$1" ]; then
    echo "The file $1 exists"
else
    echo "The file $1 does not exist"
fi