#!/bin/bash

files=$(ls "$HOME/watch")

for file in ${files[*]} 
do
    if [[ "$file" != *.back ]]; then
        cat "$HOME/watch/$file"
        mv "$HOME/watch/$file" "$HOME/watch/$file.back"
    fi
done
sleep 3