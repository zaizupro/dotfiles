#!/bin/sh

read -p "lol really stop '${1}' vm?" RESULT
if [ "saved" = "$( vboxgetstate.sh ${1} )" ];then
    VBoxManage discardstate ${1}
    echo
else
    VBoxManage controlvm $1 poweroff
    echo
fi

