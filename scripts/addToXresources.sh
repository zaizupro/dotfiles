#!/bin/bash

path=`pwd`
echo "![=============================================]" >> ./../.Xresources
echo "#include \"${path}/${1}\"" >> ./../.Xresources
echo "![=============================================]" >> ./../.Xresources
