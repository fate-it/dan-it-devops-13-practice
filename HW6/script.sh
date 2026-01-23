#!/bin/bash

target=$((RANDOM % 100 + 1))
for ((i=1;i<=5;i++)) do
        echo "Спробуйте вгадати число від 1 до 100"
        read x
        if [ "$x" -eq "$target" ]; then
                echo "Вітаємо! Ви вгадали правильне число"
                exit 0
        elif [ "$x" -lt "$target" ]; then
                echo "Занадто низько"
        elif [ "$x" -gt "$target" ]; then
                echo "Занаддто високо"
        fi
done
echo "Вибачте, у вас закінчилися спроби. Правильним числом було $target"