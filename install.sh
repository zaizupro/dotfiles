#!/usr/bin/env bash
DOTFILES=$PWD

## TODO:
##      make dependency list
##      DEPENDS="awesome ....."
##      make one installation script
##      make installation configs for each part
##      "link": {
##                   "./tmux/.tmux.conf":   "~/.tmux.conf",


showusage()
{
    echo "
usage: $0 [-t type] [-s subtype] [-h]
-t  type to use for installation
-s  subtype to use for installation
-h  display this usage information
-l  list types and subtypes
"
}

list_types()
{
    echo "
| types   | subtypes
|=========|============
| configs | all
|         |  bash
|         |  tmux
|         |  mc
|         |  urxvt
|         |  common
|         |  xres
| utils   | all
|         |  common
|         |  dev
| entries |
"
}



while getopts t:s:lfvh OPTIONS; do
    case $OPTIONS in
        t)
            # echo "t"
            TYPE=$OPTARG;;
        s)
            # echo "s"
            SUBTYPE=$OPTARG;;
        l)
            list_types;;
        f)
            # echo "f"
            force=true;;
        v)
            # echo "v"
            verbose=true;;
        h)
            # echo "h"
            showusage
            exit 1;;
        ?)
            # echo "?"
            showusage
            exit 1;;
        *)
            # echo "*"
            showusage
            exit 1;;
    esac
done

# echo "   TYPE: "$TYPE
# echo "SUBTYPE: "$SUBTYPE

##[==========================================================================]##
if [ -f ${DOTFILES}/bash/.bash_functions ]; then
    . ${DOTFILES}/bash/.bash_functions
fi

##[==========================================================================]##
LNCOMMAND="ln -vs"
if [ "$(type -t lnsafe)" = "function" ]; then
    LNCOMMAND="lnsafe"
fi

##[==========================================================================]##
CPCOMMAND="cp -v"
if [ "$(type -t cpsafe)" = "function" ]; then
    CPCOMMAND="cpsafe"
fi

MKDIRCOMMAND="mkdir -pv"


addXresEntry()
{
    local XRES="${HOME}/.Xresources"
    if [ ! -f ${XRES} ]; then
        touch ${XRES}
    fi

    local ENTRYLINE="#include \"${1}\""
    local RESULT=$(grep "${ENTRYLINE}" ${XRES})
    if [ ! -z "${RESULT}"  ]; then
        echo "[WW] [ entry '${RESULT}' found ]"
    else
        echo "" >> ${XRES}
        echo "![=============================================]" >> ${XRES}
        echo "${ENTRYLINE}" >> ${XRES}
        echo "![=============================================]" >> ${XRES}
        echo "[II] [ entry for '${1}' created]"
    fi
}
ADDXRESENTRY="addXresEntry"

HOME_BIN_DIR="${HOME}/_bin/base"


## DEBUG
    CPCOMMAND="echo copy: ";LNCOMMAND="echo make link: ";MKDIRCOMMAND="echo create directory: "; ADDXRESENTRY="echo add xres entry for : "; echo "DEBUG ENABLED"


ARGS=${#@}
if [ "..${ARGS}" = "..0" ]; then
    echo "##[=============================]##"
    echo "DOTFILES=${DOTFILES}"
    echo
    echo -e "\t$0 -t <type> -s <subtype>"
    echo "types   subtypes"
    echo "configs          "
    echo "          awesome"
    echo "          bash"
    echo "          tmux"
    echo "          mc"
    echo "          urxvt"
    echo "          common"
    echo "          xres"
    echo "          polybar"
    echo ""
    echo "utils"
    echo "entries"
fi

##[==========================================================================]##
if [ "${TYPE}" == "configs" ]; then
    #make links
    if [ "${SUBTYPE}" = "bash" ] || [ "${SUBTYPE}" = "all" ]; then
        ${LNCOMMAND} ${DOTFILES}/bash/.bash_aliases      ${HOME}/.bash_aliases
        ${LNCOMMAND} ${DOTFILES}/bash/.bash_colors       ${HOME}/.bash_colors
        ${LNCOMMAND} ${DOTFILES}/bash/.bash_functions    ${HOME}/.bash_functions
        ${LNCOMMAND} ${DOTFILES}/bash/.bash_zaz          ${HOME}/.bash_zaz
        ${LNCOMMAND} ${DOTFILES}/bash/.bash_ps1          ${HOME}/.bash_ps1
    fi

    ## tmux files
    if [ "${SUBTYPE}" = "tmux" ] || [ "${SUBTYPE}" = "all" ]; then
        ${LNCOMMAND} ${DOTFILES}/tmux/.tmux.conf         ${HOME}/.tmux.conf
        ${LNCOMMAND} ${DOTFILES}/tmux/.tmux.status.conf  ${HOME}/.tmux.status.conf
    fi

    ## mc's files
    if [ "${SUBTYPE}" = "mc" ] || [ "${SUBTYPE}" = "all" ]; then
#        echo $(${DOTFILES}/mc/install_mc.sh "${DOTFILES}" "$1")
        ${MKDIRCOMMAND} -p ${HOME}/.local/share/mc/skins
        ${LNCOMMAND} ${DOTFILES}/mc/skins/zaz.ini       ${HOME}/.local/share/mc/skins/zaz.ini
        ${LNCOMMAND} ${DOTFILES}/mc/skins/zaz8.ini      ${HOME}/.local/share/mc/skins/zaz8.ini
        ${LNCOMMAND} ${DOTFILES}/mc/skins/zaz8root.ini  ${HOME}/.local/share/mc/skins/zaz8root.

        ${MKDIRCOMMAND} -p ${HOME}/.config/mc
        ${LNCOMMAND} ${DOTFILES}/mc/ini                 ${HOME}/.config/mc/ini
        ${LNCOMMAND} ${DOTFILES}/mc/menu                ${HOME}/.config/mc/menu
        ${LNCOMMAND} ${DOTFILES}/mc/panels.ini          ${HOME}/.config/mc/panels.ini
    fi

    if [ "${SUBTYPE}" = "cmus" ] || [ "${SUBTYPE}" = "all" ]; then
        ${MKDIRCOMMAND} -p ${HOME}/.config/cmus
        ${LNCOMMAND} ${DOTFILES}/cmus/industrial.theme  ${HOME}/.config/cmus/industrial.theme
    fi

    ## urxvt's files
    if [ "${SUBTYPE}" = "urxvt" ] || [ "${SUBTYPE}" = "all" ]; then
         ${LNCOMMAND} ${DOTFILES}/urxvt/.urxvtrc ${HOME}/.urxvtrc
         echo "install urxvt patch from ${DOTFILES}/urxvt"
    fi

    ## common files
    if [ "${SUBTYPE}" = "common" ] || [ "${SUBTYPE}" = "all" ]; then
        ${LNCOMMAND} ${DOTFILES}/.tigrc                  ${HOME}/.tigrc
        ${LNCOMMAND} ${DOTFILES}/.xterm                  ${HOME}/.xterm
        ${LNCOMMAND} ${DOTFILES}/.rofi.conf              ${HOME}/.rofi.conf
        ${LNCOMMAND} ${DOTFILES}/.nanorc                 ${HOME}/.nanorc
        ${LNCOMMAND} ${DOTFILES}/.gitconfig              ${HOME}/.gitconfig
        ${CPCOMMAND} ${DOTFILES}/.gitconfig.user         ${HOME}/.gitconfig.user
    fi

    ## xres files
    if [ "${SUBTYPE}" = "xres" ] || [ "${SUBTYPE}" = "all" ]; then
        ${LNCOMMAND} ${DOTFILES}/Xresources.colors/default    ${HOME}/.Xresources.colors
    fi

    ## polybar files
    if [ "${2}" = "polybar" ] || [ "${2}" = "all" ]; then
        ${MKDIRCOMMAND} ${HOME}/.config/polybar
        ${LNCOMMAND} ${DOTFILES}/polybar/config    ${HOME}/.config/polybar/config
    ## awesome files
    if [ "${SUBTYPE}" = "awesome" ] || [ "${SUBTYPE}" = "all" ]; then
        ${LNCOMMAND} ${DOTFILES}/awesome/autorun    ${HOME}/.config/awesome/autorun
        # add to ${HOME}/.config/awesome/rc.lua: 
        # require("awful").spawn.with_shell("~/.config/awesome/autorun")
    fi

    echo "[II] [ installing ${TYPE} ${SUBTYPE}: done ]"
fi

if [ "${TYPE}" = "utils" ]; then

    ${MKDIRCOMMAND} ${HOME_BIN_DIR}

    if [ "${SUBTYPE}" = "all" ]; then
        ${LNCOMMAND} ${DOTFILES}/scripts      ${HOME_BIN_DIR}
    fi

fi



if [ "${TYPE}" = "entries" ]; then
    ${ADDXRESENTRY} ".urxvtrc"
    ${ADDXRESENTRY} ".Xresources.colors"
    ${ADDXRESENTRY} ".rofi.conf"
fi



