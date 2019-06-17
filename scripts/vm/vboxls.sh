#!/bin/sh


if [ -z "${1}" ]; then
    VBoxManage list vms | cut -d '"' -f 2
else
    if [ "${1}" == "full" ]; then
        VBoxManage list vms
    fi
fi

