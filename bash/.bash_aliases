##[==========================================================================]##
##[                              ALIASES                                     ]##
##[==========================================================================]##
##-=[moving]=-##
alias s='cd ..'
alias b='cd -'
alias cds='cd $WORKSPACE'
alias cdd='cd $DOTFILES'
alias cde='cd ${HOME}/_EXP'
alias cdh='cd ${HOME}/_hints'
alias cdn='cd $(getNexusPath.sh)'
alias cdusb='cd ~/_usb'

##[==========================================================================]##
##-=[shell rutina]=-##
alias userls='cut -f1 -d: /etc/passwd'
alias homesize='du -hs ~'
alias topc='top -o%CPU'
alias topm='top -o%MEM'
alias rpmlist="rpm -qa --queryformat '%010{SIZE}\t%{NAME}-%{VERSION}-%{RELEASE}\n'"
alias psw='ps xawwf -eo pid,user,%cpu,%mem,args | less -S'
alias mktd='mkdir $(date +%Y%m%d)'

##[==========================================================================]##
##-=[print files]=-##

__filtor()
{    awk '{print $1"  "(substr($5"    ", 1, 4))"  "(substr($9,1))}'; }
__ll()
{    ls -lahF --color=no $@ |__filtor;   }

#ls -lAhF  |  awk '{out="";for(i=9;i<=NF;i++){out=out" "$i};print $1" "$5""out}'

alias grep="grep --color=auto $@"

alias grepdat="_(){
          grep -n \${1} . -rI
          }; _\$@"

#grep -n '\<\${1}\>' . -rI

#amixer set Master toggle

alias settitle="_(){
           TITLENAME=\${1} \
           PROMPT_COMMAND='echo -ne \"\033]0;\${TITLENAME}\007\"'
           }; _\$@"


alias ll='ls -AhFGg --time-style=+ --group-directories-first'
alias lll='ls -lAF --color=no'  #TODO make colorifikator of permishons
#alias ll='ls -lahF --color=no |__filtor'

alias getrandomcolor="_(){
             echo $((1 + RANDOM % 10))
            }; _\$@"

## list hidden files
alias lsh='ls -A | grep "^\."'

alias gitl='git log --format=oneline'

alias ipa='ip a | grep "inet " | awk '\''{print $2}'\'' '

#du -h --max-depth=1 | sort -h

#ps -eo "pid,comm,rss"  --sort rss

duh() {
  var=$(
    if [ -z $1 ]; then
      echo "./*"
    else
      echo "$1/*"
    fi
    )
  du -s --si $var | sort -h
}


# Tell to df to don't see the supermount filesystems.
#alias df='df -x supermount'

##[==========================================================================]##
##-=[dev]=-##
alias remek='kek "$@" && mek "$@"'
alias tigs='tig status'
alias meki='mek install -s "$@"'

alias gitusers="git shortlog | grep -E '^[^ ]'"

SETTERM="TERM=xterm-256color"

alias tma='_(){
           SESSIONNAME=${1}
           export ${SETTERM}
           [ ${#SESSIONNAME} == 0 ]; tmls && return 0
           [ $(tmux has -t ${SESSIONNAME} >/dev/null 2>&1 ;echo $?) == 0 ] \
           &&  tmux attach -t ${SESSIONNAME} \
           || tmux new -s ${SESSIONNAME}
           }; _'

alias tmn='export ${SETTERM}; tmux new -s'
alias tmls='tmux ls'
alias tmk='tmux kill-session -t'
alias tmr='tmux rename-window $(basename $PWD)'

# 'xclip -selection clipboard -o | xsel -i -p'
##[==========================================================================]##
##-=[ungrouped]=-##
#alias fixpng='find . -type f -name *.png -exec convert {} -strip {} \;'
alias pup='sudo pacman -Suy --color=auto $@'
alias pacman='pacman --color=auto $@'
alias pins='sudo pacman -S --color=auto $@'


alias pw='sudo pacman $2 $1'

alias merge='xrdb -merge ${HOME}/.Xresources'
#identify -format '%[EXIF:*]'


alias makepass='openssl rand -base64 12'
alias vm='startVM.sh'
alias fm='thunarStarter.sh'

alias mc='mcwrp /usr/bin/mc $@'
alias mcedit='mcwrp /usr/bin/mcedit $@'
alias mcview='mcwrp /usr/bin/mcview $@'
alias mcdiff='mcwrp /usr/bin/mcdiff $@'


## Stolen from github.com/zanshin
## Just for fun
##alias please='sudo !!'
alias please='sudo '
alias fail='tail -f'

## Enable aliases to be sudo’ed
alias sudo='sudo '

##[==========================================================================]##
##-=[NET aliases]=-##
##global
##ifconfig eth0:0 inet 192.168.0.240 netmask 0xffff0000





