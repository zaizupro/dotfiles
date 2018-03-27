#!/bin/sh
./sofwget.sh "$(echo "$(mocp -Q %artist)") $(echo "$(mocp -Q %album)")"
