#!/bin/bash
DOTFILES=$PWD

## TODO:
##      make dependency list
##      DEPENDS="awesome ....."
##      make one installation script
##      make installation configs for each part
##      "link": {
##                   "./tmux/.tmux.conf":   "~/.tmux.conf",



##[==========================================================================]##
if [ -f $DOTFILES/bash/.bash_functions ]; then
    . $DOTFILES/bash/.bash_functions
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
    XRES="${HOME}/.Xresources"
    if [ ! -f ${XRES} ]; then
        touch ${XRES}
    fi

    ENTRYLINE="#include \"${1}\""
    RESULT=$(grep "${ENTRYLINE}" ${XRES})
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




## DEBUG
    CPCOMMAND="echo copy: ";LNCOMMAND="echo make link: ";MKDIRCOMMAND="echo create directory: "; ADDXRESENTRY="echo add xres entry for : "


ARGS=${#@}
if [ "..${ARGS}" == "..0" ]; then
    echo "##[=============================]##"
    echo "DOTFILES=${DOTFILES}"
    echo
    echo -e "\t$0 <type> <category>"
    echo "types   categories"
    echo "configs          "
    echo "          bash"
    echo "          tmux"
    echo "          mc"
    echo "          urxvt"
    echo "          common"
    echo "          xres"
    echo ""
    echo "utils"
    echo "entries"
fi

##[==========================================================================]##
if [ "${1}" == "configs" ]; then
    #make links
    if [ "${2}" == "bash" ] || [ "${2}" = "all" ]; then
        ${LNCOMMAND} $DOTFILES/bash/.bash_aliases      $HOME/.bash_aliases
        ${LNCOMMAND} $DOTFILES/bash/.bash_colors       $HOME/.bash_colors
        ${LNCOMMAND} $DOTFILES/bash/.bash_functions    $HOME/.bash_functions
        ${LNCOMMAND} $DOTFILES/bash/.bash_zaz          $HOME/.bash_zaz
    fi

    ## tmux files
    if [ "${2}" = "tmux" ] || [ "${2}" = "all" ]; then
        ${LNCOMMAND} $DOTFILES/tmux/.tmux.conf         $HOME/.tmux.conf
        ${LNCOMMAND} $DOTFILES/tmux/.tmux.status.conf  $HOME/.tmux.status.conf
    fi

    ## mc's files
    if [ "$2" == "mc" ] || [ "${2}" = "all" ]; then
#        echo $($DOTFILES/mc/install_mc.sh "${DOTFILES}" "$1")
        ${MKDIRCOMMAND} -p ${HOME}/.local/share/mc/skins
        ${LNCOMMAND} ${DOTFILES}/mc/skins/zaz.ini       ${HOME}/.local/share/mc/skins/zaz.ini
        ${LNCOMMAND} ${DOTFILES}/mc/skins/zaz8.ini      ${HOME}/.local/share/mc/skins/zaz8.ini
        ${LNCOMMAND} ${DOTFILES}/mc/skins/zaz8root.ini  ${HOME}/.local/share/mc/skins/zaz8root.

        ${MKDIRCOMMAND} -p ${HOME}/.config/mc
        ${LNCOMMAND} ${DOTFILES}/mc/ini                 ${HOME}/.config/mc/ini
        ${LNCOMMAND} ${DOTFILES}/mc/menu                ${HOME}/.config/mc/menu
        ${LNCOMMAND} ${DOTFILES}/mc/panels.ini          ${HOME}/.config/mc/panels.ini
    fi

    ## urxvt's files
    if [ "$2" == "urxvt" ] || [ "${2}" = "all" ]; then
         ${LNCOMMAND} ${DOTFILES}/urxvt/.urxvtrc ${HOME}/.urxvtrc
         echo "install urxvt patch from ${DOTFILES}/urxvt"
    fi

    ## common files
    if [ "$2" == "common" ] || [ "${2}" = "all" ]; then
        ${LNCOMMAND} $DOTFILES/.tigrc                  $HOME/.tigrc
        ${LNCOMMAND} $DOTFILES/.xterm                  $HOME/.xterm
        ${LNCOMMAND} $DOTFILES/.gitconfig              $HOME/.gitconfig
        ${CPCOMMAND} $DOTFILES/.gitconfig.user         $HOME/.gitconfig.user
    fi

    ## xres files
    if [ "$2" == "xres" ] || [ "${2}" = "all" ]; then
        ${LNCOMMAND} $DOTFILES/Xresources.colors/default    $HOME/.Xresources.colors
    fi


    echo "[II] [ installing ${1} ${2}: done ]"
fi

if [ "${1}" == "utils" ]; then

    ${MKDIRCOMMAND} ${HOME}/_bin

    if [ "${2}" == "common" ] || [ "${2}" = "all" ]; then
        ${LNCOMMAND} $DOTFILES/scripts/mcwrp      ${HOME}/_bin/mcwrp
    fi
    if [ "${2}" == "dev" ] || [ "${2}" = "all" ]; then
        ${LNCOMMAND} $DOTFILES/scripts/kek      ${HOME}/_bin/kek
        ${LNCOMMAND} $DOTFILES/scripts/mek      ${HOME}/_bin/mek
        ${LNCOMMAND} $DOTFILES/scripts/makek.sh      ${HOME}/_bin/makek.sh
    fi

fi



if [ "${1}" == "entries" ]; then
    ${ADDXRESENTRY} ".urxvtrc"
    ${ADDXRESENTRY} ".Xresources.colors"
fi



