#!/bin/bash
DOTFILES=$PWD
echo PWD=${PWD}

if [ "$1" == "configs" ]; then
    #make links
        ln -s $DOTFILES/mc/skins/zaz.ini        $HOME/.local/share/mc/skins/zaz.ini

        ln -s  $DOTFILES/mc/ini                 $HOME/.config/mc/ini
        ln -s  $DOTFILES/mc/menu                $HOME/.config/mc/menu
        ln -s  $DOTFILES/mc/panels.ini          $HOME/.config/mc/panels.ini

    echo
else
    echo
    # sudo cp $DOTFILES/mc/skins/zaz.ini /usr/share/mc/skins/zaz.ini
fi
