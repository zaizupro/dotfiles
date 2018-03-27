#!/bin/bash

count=2
imagelink=$(wget --user-agent 'Mozilla/5.0' -qO - "www.google.com/search?q=$1\&tbm=isch" | sed 's/</\n</g' | grep '<img' | head -n"$count" | tail -n1 | sed 's/.*src="\([^"]*\)".*/\1/')
feh -Z $imagelink -g 300x300
