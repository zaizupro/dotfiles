#!/bin/sh

PURPFGBG=$(tput setab 54;tput setaf 183)
YELLOWFGBG=$(tput setab 94;tput setaf 220)
REDFGBG=$(tput setab 52;tput setaf 196)
GREENFGBG=$(tput setab 58;tput setaf 154)
NC=$(tput sgr0)

get_colored_state()
{

    if [ -z "${1}" ]; then
        return 1
    else
        VMNAME=${1}
    fi

    VM_NAME_IS_VALID=$(VBoxManage showvminfo ${VMNAME} --machinereadable > /dev/null 2>&1 ;echo $?)
    if  [ ${VM_NAME_IS_VALID} -eq 0 ]; then
        VMSTATE=$(VBoxManage showvminfo ${VMNAME} --machinereadable | grep VMState= | cut -d '"' -f 2)
    else
        echo "${REDFGBG}error: bad name '${VMNAME}'${NC}"
        return 2
    fi


    case "${VMSTATE}" in
        aborted)
        COLOR="${REDFGBG}"
        ;;
        saved)
        COLOR="${YELLOWFGBG}"
        ;;
        poweroff)
        COLOR="${PURPFGBG}"
        ;;
        running)
        COLOR="${GREENFGBG}"
        ;;
        *)
        ;;
    esac

    echo "${COLOR}${VMNAME} is ${VMSTATE}${NC}"

}


if [ -z "${1}" ]; then
    for NAME in $(vboxls.sh) ;do
        get_colored_state "${NAME}"
    done
    exit 1
else
    VMNAME=${1}
    get_colored_state "${VMNAME}"
fi

