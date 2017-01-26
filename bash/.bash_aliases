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
alias ll='ls -lahF --color=no'
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

alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'
alias tk='tmux kill-session -t'


alias makepass='openssl rand -base64 12'
alias vm='startVM.sh'
alias fm='thunarStarter.sh'

#if [ $TERM = "linux" ]; then
if [ "$(tput colors).." = "8.." ];
    if [ $USER = "root" ]; then
	myMCFallbackSkin="zaz8root"
    else
	myMCFallbackSkin="zaz8"
    fi
    alias mc="mc --skin $myMCFallbackSkin"
    alias mcedit="mcedit --skin $myMCFallbackSkin"
    alias mcview="mcview --skin $myMCFallbackSkin"
    alias mcdiff="mcdiff --skin $myMCFallbackSkin"
fi


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





