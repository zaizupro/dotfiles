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


if [ "saved" = "$( vboxgetstate.sh ${VMNAME} )" ]; then
    VBoxHeadless -startvm ${VMNAME} --vrde=off > /dev/null &
else
    VBoxHeadless -startvm ${VMNAME} --vrde=off > /dev/null &
fi

sleep 1
echo "vm ${VMNAME} is started"
