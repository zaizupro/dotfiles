#!/bin/sh

updates=$(checkupdates | wc -l)

if [ "$updates" -gt 0 ]; then
    if [ "${#updates}" -eq 1 ]; then
        echo "[ $updates ]"
    else if [ "${#updates}" -eq 2 ]; then
            echo "[ $updates]"
        else
            echo "[$updates]"
        fi
    fi
else
    echo "[---]"
fi
