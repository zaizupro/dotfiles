#! /bin/bash
track=`mocp -Q %title | cut -d " " -f 1`
if [ $(echo $track | wc -L) -lt 2 ] && [ "$(echo $track | grep [0-9])" = "$track" ] ; then track="0$track" ; fi
notify-send -i "/usr/share/icons/Humanity/emblems/48/emblem-sound.svg" \
"$track - $(mocp -Q ' %song')" "$(mocp -Q '%artist - %album') $(mocp -Q '(%tt)')"
