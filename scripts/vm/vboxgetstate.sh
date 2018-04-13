#!/bin/sh

YELLOWFGBG=$(tput setab 94;tput setaf 220)
REDFGBG=$(tput setab 52;tput setaf 196)
GREENFGBG=$(tput setab 58;tput setaf 154)
NC=$(tput sgr0)


VMNAME=${1}
VMSTATE=$(VBoxManage showvminfo ${VMNAME} --machinereadable | grep VMState= | cut -d '"' -f 2)

case "${VMSTATE}" in 
    aborted)
    COLOR="${REDFGBG}"
    ;;
    saved)
    COLOR="${YELLOWFGBG}"
    ;;
    poweroff)
    COLOR="${NC}"
    ;;
    running)
    COLOR="${GREENFGBG}"
    ;;
    *)
    ;;
esac

echo "${COLOR}${VMNAME} is ${VMSTATE}${NC}"
