#!/bin/bash

HomePath=$HOME
XresourcesPath="${HomePath}/.Xresources"
echo "![=============================================]" >> ${XresourcesPath}
echo "#include \"${1}\"" >> ${XresourcesPath}
echo "![=============================================]" >> ${XresourcesPath}
