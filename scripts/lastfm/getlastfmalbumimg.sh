#!/bin/sh
curl "http://www.last.fm/ru/music/""$1""/+albums" |grep -i "$2" |grep "img class"| awk -F'"' '{ print $4}'
