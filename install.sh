#!/bin/bash
DOTFILES=$PWD


if [ -f ~/.bash_zaz ]; then
    . $DOTFILES/bash/.bash_functions
fi


LNCOMMAND="ln -s"
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

## common files
    if [ "$2" == "common" ]; then
        ${LNCOMMAND} $DOTFILES/.tigrc                  $HOME/.tigrc
        ${LNCOMMAND} $DOTFILES/.xterm                  $HOME/.xterm
    fi

    echo
else
    echo
fi


