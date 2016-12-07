#!/bin/sh
feh $(./getlastfmalbumimg.sh "$(echo "$(mocp -Q %artist)")" "$(echo "$(mocp -Q %album)")")
