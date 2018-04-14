#!/bin/bash

VALUE=${1}
if [ 0 -eq ${#VALUE} ]; then
    exit 1;
fi

PVALUE=$(expr ${VALUE} / 10)
OUT=
#SEPARATOR=" "


for i in $(seq 1 ${PVALUE} )
do
    if [ 0 -ne ${#OUT} ]; then
        OUT=${OUT}${SEPARATOR}
    fi
#    OUT=${OUT}"█"
#    OUT=${OUT}"▮"
#    OUT=${OUT}"❚"
#    OUT=${OUT}"❙"
#░░░░░░▒▒▒▒▓▓▓▓▓
    OUT=${OUT}"▓"
done

for i in $(seq 1 $(expr 10 - ${PVALUE}) )
do
    if [ 0 -ne ${#OUT} ]; then
        OUT=${OUT}${SEPARATOR}
    fi
    OUT=${OUT}"▒"
done

echo -e "$OUT"