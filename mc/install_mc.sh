#!/bin/bash

__install_usage()
{
    echo '[II] USAGE: '
    echo '    '${1}' DOTFILESPATH CATEGORY '
    echo
}


if [ "$#" -ne 2 ]; then
    echo "[EE] [ Illegal number of parameters ]"
    echo '[II] [ Stay safe, stay legal ]'
    __install_usage ${0}
    exit 1
fi

DOTFILESPATH=${1}

RESULT=1
if [ -e ${DOTFILESPATH} ]; then
    RESULT=0
else
    if [ -L ${DOTFILESPATH} ]; then
       RESULT=0
    fi
fi

if [ "..${RESULT}" != "..0" ];then
    echo "[EE] [ DOTFILESPATH:'${DOTFILESPATH}' not exists ]"
    __install_usage ${0}
    exit 2
fi

DOTFILESFULLPATH=$(cd ${DOTFILESPATH}&&echo $(pwd -L))
# echo '[DD] [ DOTFILESFULLPATH: '${DOTFILESFULLPATH}' ]'
# echo '[DD] [ PWD: '${PWD}' ]'


##================CUSTOM_FUNCTIONS===================
## Source bash functions, if present
if [ -f $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi

LNCOMMAND="ln -s"
if [ $(type -t lnsafe) = "function" ]; then
    LNCOMMAND="lnsafe"
fi


if [ "$2" == "configs" ]; then
    mkdir -p ${HOME}/.local/share/mc/skins
    #make links
    ${LNCOMMAND} ${DOTFILESFULLPATH}/mc/skins/zaz.ini       ${HOME}/.local/share/mc/skins/zaz.ini
    ${LNCOMMAND} ${DOTFILESFULLPATH}/mc/skins/zaz8.ini      ${HOME}/.local/share/mc/skins/zaz8.ini
    ${LNCOMMAND} ${DOTFILESFULLPATH}/mc/skins/zaz8root.ini  ${HOME}/.local/share/mc/skins/zaz8root.ini

    ${LNCOMMAND} ${DOTFILESFULLPATH}/mc/ini                 ${HOME}/.config/mc/ini
    ${LNCOMMAND} ${DOTFILESFULLPATH}/mc/menu                ${HOME}/.config/mc/menu
    ${LNCOMMAND} ${DOTFILESFULLPATH}/mc/panels.ini          ${HOME}/.config/mc/panels.ini
    echo
else
    echo
    echo '[II] [ nothing ]'
fi
