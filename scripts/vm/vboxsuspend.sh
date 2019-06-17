#!/bin/sh

if [ -z "${1}" ]; then
    if [ $(type selectdat > /dev/null  2>&1 ;echo $?) == "0" ]; then
        VMNAME=$(selectdat $(vboxls.sh))
    else
        echo "selectdat not found. vm name is required"
        exit 1
    fi
else
    VMNAME=${1}
fi


VBoxManage controlvm ${VMNAME} savestate


#urxvt -e sh -c "vboxsuspend.sh ${VMNAME} ;read" &
