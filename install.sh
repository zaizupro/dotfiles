#!/bin/bash
DOTFILES=$PWD


if [ "$1" == "configs" ]; then
    #make links
    if [ "$2" == "bash" ]; then
        ln -s $DOTFILES/bash/.bash_aliases      $HOME/.bash_aliases
        ln -s $DOTFILES/bash/.bash_colors       $HOME/.bash_colors
        ln -s $DOTFILES/bash/.bash_functions    $HOME/.bash_functions
        ln -s $DOTFILES/bash/.bash_zaz          $HOME/.bash_zaz
    fi
    if [ "$2" == "tmux" ]; then
        ln -s $DOTFILES/tmux/.tmux.conf         $HOME/.tmux.conf
        ln -s $DOTFILES/tmux/.tmux.status.conf  $HOME/.tmux.status.conf
    fi

    if [ "$2" == "mc" ]; then
        echo $($DOTFILES/mc/install_mc.sh "$1")
    fi


    ln -s $DOTFILES/.tigrc                  $HOME/.tigrc
    ln -s $DOTFILES/.xterm                  $HOME/.xterm


    echo
else
    echo
fi


