#!/bin/sh
NEWADDR=127.0.0.1
MARKER=moimarker_db
echo -en  $(cat /etc/hosts_test | sed 's|.*'"${MARKER}"'|'"$NEWADDR"'         db \#"'${MARKER}'"|g' ) >  ./lol


