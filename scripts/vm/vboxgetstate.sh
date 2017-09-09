#!/bin/sh

VMNAME=${1}
VMSTATE=$(VBoxManage showvminfo ${VMNAME} --machinereadable | grep VMState= | cut -d '"' -f 2)

echo "$(tput setab 58;tput setaf 154)$VMNAME is $VMSTATE"
