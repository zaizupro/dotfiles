#!/bin/sh

## input - sources.cpp

## for extra INCLude paths
source ./tegmek.conf
CXXFLAGS="-fPIC -std=c++11"

gcc ${CXXFLAGS} -M "$@" ${INCL} | sed -e 's/[\\ ]/\n/g' | \
        sed -e '/^$/d' -e '/\.o:[ \t]*$/d' | \
        ctags -L - --c++-kinds=+p --fields=+iaS --extra=+q
