#!/bin/sh

if [ "saved" = "$( vboxgetstate.sh ${1} )" ];then
    VBoxHeadless -startvm ${1} --vrde=off > /dev/null &
else
    VBoxHeadless -startvm ${1} --vrde=off > /dev/null &
fi
sleep 1
echo "vm ${1} is started"
