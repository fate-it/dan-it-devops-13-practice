#!/bin/bash

files=$(ls ~/watch)

for file in ${files[*]} 
do
    if [ ${file:$(${#file}-5):${#file}} != ".back" ]; then
        cat "~/watch/$file"
        mv "~/watch/$file" "~/watch/$file.back"
    fi
done