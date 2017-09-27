##[==========================================================================]##
##[                              ALIASES                                     ]##
##[==========================================================================]##
##-=[moving]=-##
alias s='cd ..'
alias b='cd -'
alias cds='cd $WORKSPACE'
alias cdd='cd $DOTFILES'
alias cde='cd ~/_EXP'
alias cdn='cd $(getNexusPath.sh)'
alias cdusb='cd ~/_usb'

##[==========================================================================]##
##-=[shell rutina]=-##
alias userls='cut -f1 -d: /etc/passwd'
alias homesize='du -hs ~'
alias topc='top -o%CPU'
alias topm='top -o%MEM'
alias rpmlist="rpm -qa --queryformat '%010{SIZE}\t%{NAME}-%{VERSION}-%{RELEASE}\n'"
alias psw='ps auxf|less -S'

##[==========================================================================]##
##-=[print files]=-##

__filtor()
{    awk '{print $1"  "(substr($5"    ", 1, 4))"  "(substr($9,1))}'; }
__ll()
{    ls -lahF --color=no $@ |__filtor;   }

alias ll='__ll'
#alias ll='ls -lahF --color=no |__filtor'

## list hidden files
alias lsh='ls -a | grep "^\."' 

alias gitl='git log --format=oneline'


# Tell to df to don't see the supermount filesystems.
#alias df='df -x supermount'

##[==========================================================================]##
##-=[dev]=-##
alias remek='kek "$@" && mek "$@"'
alias tigs='tig status'

alias gitusers="git shortlog | grep -E '^[^ ]'"

alias tma='_(){
           SESSIONNAME=${1}
           [ $(tmux has -t ${SESSIONNAME} >/dev/null 2>&1 ;echo $?) == 0 ] \
           &&  tmux attach -t ${SESSIONNAME} \
           || tmux new -s ${SESSIONNAME}
           }; _'

alias tmn='tmux new -s'
alias tmls='tmux ls'
alias tmk='tmux kill-session -t'


alias makepass='openssl rand -base64 12'
alias vm='startVM.sh'
alias fm='thunarStarter.sh'

alias mc="mcwrp mc $@"
alias mcedit="mcwrp mcedit $@"
alias mcview="mcwrp mcview $@"
alias mcdiff="mcwrp mcdiff $@"


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





