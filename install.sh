#!/bin/bash
DOTFILES=$PWD

## TODO:
##      make dependency list
##      DEPENDS="awesome ....." 
##      make one installation script
##      make installation configs for each part
##      "link": {
##                   "./tmux/.tmux.conf":   "~/.tmux.conf",



if [ -f $DOTFILES/bash/.bash_functions ]; then
    . $DOTFILES/bash/.bash_functions
fi


LNCOMMAND="ln -vs"
if [ "$(type -t lnsafe)" = "function" ]; then
    LNCOMMAND="lnsafe"
fi



##[============================================================================]##
if [ "$1" == "configs" ]; then
    #make links
    if [ "$2" == "bash" ]; then
        ${LNCOMMAND} $DOTFILES/bash/.bash_aliases      $HOME/.bash_aliases
        ${LNCOMMAND} $DOTFILES/bash/.bash_colors       $HOME/.bash_colors
        ${LNCOMMAND} $DOTFILES/bash/.bash_functions    $HOME/.bash_functions
        ${LNCOMMAND} $DOTFILES/bash/.bash_zaz          $HOME/.bash_zaz
    fi

    ## tmux files
    if [ "$2" == "tmux" ]; then
        ${LNCOMMAND} $DOTFILES/tmux/.tmux.conf         $HOME/.tmux.conf
        ${LNCOMMAND} $DOTFILES/tmux/.tmux.status.conf  $HOME/.tmux.status.conf
    fi

    ## mc's files
    if [ "$2" == "mc" ]; then
        echo $($DOTFILES/mc/install_mc.sh "${DOTFILES}" "$1")
    fi

    ## urxvt's files
    if [ "$2" == "urxvt" ]; then
#        echo $($DOTFILES/mc/install_mc.sh "${DOTFILES}" "$1")
         echo kek
    fi

    ## common files
    if [ "$2" == "common" ]; then
        ${LNCOMMAND} $DOTFILES/.tigrc                  $HOME/.tigrc
        ${LNCOMMAND} $DOTFILES/.xterm                  $HOME/.xterm
        ${LNCOMMAND} $DOTFILES/.gitconfig              $HOME/.gitconfig
        touch $HOME/.gitconfig.user
    fi

    ## patch Xresources

    echo "[ installing ${1} ${2}: done ]"
fi

if [ "$1" == "utils" ]; then
    
    mkdir -pv ${HOME}/_bin
    
    #if [ "$2" == "common" ]; then
        ${LNCOMMAND} $DOTFILES/scripts/mcwrp      ${HOME}/_bin/mcwrp
    #fi
    #if [ "$2" == "dev" ]; then

    #fi

    
    
    
fi



