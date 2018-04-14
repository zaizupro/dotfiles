
xrdb ~/.Xresources

feh  --image-bg black --bg-scale ${HOME}/.BGWALPPR

#xautolock -time 10 -locker slock

compton &
sxhkd &
exec bspwm

