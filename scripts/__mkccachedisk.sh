#!/bin/sh

CCACHEPATH=${1}
sudo mount -t tmpfs -o size=512m tmpfs ${CCACHEPATH}


##tmpfs       /home/user/.ccache         tmpfs   defaults,size=5G     0 0
##
