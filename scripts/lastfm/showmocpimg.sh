#!/bin/sh
feh $(./getlastfmalbumimg.sh "$(echo "$(mocp -Q %artist)")" "$(mocp -Q %album)")
