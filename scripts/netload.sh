#!/bin/sh

if [ -z "$1" ]; then
    echo
    echo "    usage: $0 network-interface"
    echo
    ARR=($(ip a  | grep -o  "^[0-9]*:\ \w*" | cut -d ' ' -f 2 | uniq))
    echo "    e.g.:"
    echo "         $(basename $0) ${ARR[$i]}"
    echo
    echo "network-interfaces:"
    for i in "${!ARR[@]}"; do
        echo -e "    ${ARR[$i]}"
    done
    exit
fi


X_TYPE="all"
VERBOSITY=false

if [ ! -z "${2}" ]; then
    if [ "${2}" == "rx" ] || [ "${2}" == "tx" ]; then
        X_TYPE=${2}
        if [ ! -z "${3}" ]; then
            if [ "${3}" == "-v" ]; then
                VERBOSITY=true
            fi
        fi
    fi

    if [ "${2}" == "-v" ]; then
        VERBOSITY=true
    fi
fi

IF=$1

## TODO check $1 in ARR[@]
R1=$(cat /sys/class/net/$1/statistics/rx_bytes)
T1=$(cat /sys/class/net/$1/statistics/tx_bytes)
sleep 1

if [ "$X_TYPE" == "rx" ] || [ "$X_TYPE" == "all" ]; then
    R2=$(cat /sys/class/net/$1/statistics/rx_bytes)
    RBPS=$(expr $R2 - $R1)
    RKBPS=$(expr $RBPS / 1024)
fi

if [ "$X_TYPE" == "tx" ] || [ "$X_TYPE" == "all" ]; then
    T2=$(cat /sys/class/net/$1/statistics/tx_bytes)
    TBPS=$(expr $T2 - $T1)
    TKBPS=$(expr $TBPS / 1024)
fi

if [ "$X_TYPE" == "rx" ] || [ "$X_TYPE" == "all" ]; then

    if [ "${VERBOSITY}" == "true" ]; then
        PREFIX_X_TYPE="rx "
    fi
    # printf "%s%d \n" "$PREFIX_X_TYPE" "$RKBPS"
    printf "%s%d \n" "$PREFIX_X_TYPE" "$RBPS"
fi
if [ "$X_TYPE" == "tx" ] || [ "$X_TYPE" == "all" ]; then
    # printf "%s%d \n" "$PREFIX_X_TYPE" "$TKBPS"
    printf "%s%d \n" "$PREFIX_X_TYPE" "$TBPS"
fi



