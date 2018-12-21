#!/bin/bash



# Colored Make 2015.2.11
# Copyright (c) 2014 Renato Silva
# GNU GPLv2 licensed


#extended by zaz 2015

#==============COLORS============
# add some color
if [ -f ${HOME}/.bash_colors ]; then
    source ${HOME}/.bash_colors
fi


# This script will colorize output of make and GCC so it becomes easier to
# notice the errors and warnings in the complex build output.

# Enable 256 colors for MinTTY in MSYS2
if [[ "$MSYSCON" = mintty* && "$TERM" = *256color* ]]; then
    red="\e[38;05;9m"
    green="\e[38;05;76m"
    blue="\e[38;05;74m"
    cyan="\e[0;36m"
    purple="\e[38;05;165m"
    yellow="\e[0;33m"
    gray="\e[38;05;244m"
else
    red="\e[1;31m"
    green="\e[1;32m"
    blue="\e[1;34m"
    cyan="\e[1;36m"
    purple="\e[1;35m"
    yellow="\e[1;33m"
    gray="\e[1;30m"
fi
normal="\e[0m"

# Errors, warnings, notes and compiler recipes
KEY="s/(\[-W.*\])/${YELLOWFGBG}\\1${NC}/i"
error="s/(^.*)(multiple definition|\ error|[^a-zA-Z]error:|undefined reference to|[^a-z]undefined reference to)(.*)/${NC}${REDFG}\\1${NC}${REDFGBG}\2${REDFGBG}${YELLOW}\3${NC}/i"
note="s/(^note|^.*[^a-z]note:)/$(printf $green)\\1$(printf $normal)/i"
warning="s/(^warning|^.*[^a-z]warning:)/$(printf $yellow)\\1$(printf $normal)/i"
compile_line="s/(^g\+\+\ |^[^ ]*moc\ )(.*)(\ .*\.c[^ ]*|\ .*\.moc)/${YELLOWFGBG}\\1${NC}\2${YELLOWFGBG}\3${NC}/i"
make="s/(^make(\[[0-9]+\])?:|.*Configuring project)(.*)/${PURPFGBG}\\1${NC}\2${PURP}\3${NC}/i"
cxx="s/(std=c++)(\[[0-9]+\])?:/$(printf $purple)std=c++\\1:$(printf $normal)/"
compiler_recipe="s/^(gcc(.exe)? .*)/$(printf $gray)\\1$(printf $normal)/"
install="s/(^install)(.*)/${GREENFGBG}\\1${NC}${GREEN}\2${NC})/i"
debug_flag="s/(\ -g\ )/${GREENFGBG}\\1${NC}/"

if [[ $(uname -or) != 1.*Msys ]]; then
    command make "$@" 2> >(sed -r -e "$warning" -e "$debug_flag" -e "$error" -e "$compile_line" -e "$note" -e "$undefined_reference_to" -e "$cxx" -e "$make" -e "$compiler_recipe" -e"$install" -e "$KEY") \
                       > >(sed -r -e "$warning" -e "$debug_flag" -e "$error" -e "$compile_line" -e "$note" -e "$undefined_reference_to" -e "$cxx" -e "$make" -e "$compiler_recipe" -e"$install" -e "$KEY")
else
    # MinGW MSYS does not support process substitution
    command make "$@" 2>&1 | sed -r -e "$warning" -e "$error" -e "$make" -e "$compiler_recipe"
fi
