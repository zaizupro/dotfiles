#!/bin/bash

if [ -f $HOME/.bash_zaz ]; then
    source $HOME/.bash_zaz
fi

if [ "$1" == "configs" ]; then
    #make link 
    ln -s $DOTFILES/urxvt/.urxvtrc $HOME/.urxvtrc
else
    sudo cp $DOTFILES/urxvt/perl_ext/tabbedex/tabbedex /usr/lib/urxvt/perl/tabbedex
    sudo patch /usr/lib/urxvt/perl/tabbedex $DOTFILES/urxvt/tabbedexKillTab.patch
fi
