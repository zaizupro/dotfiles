
##include dat  in .bashrc

__ddiff()
{
    svn diff |sed 's/^-/\x1b[30m\x1b[41m-/;s/^+/\x1b[30m\x1b[42m+/;s/^@/\x1b[30m\x1b[43m@/;s/$/\x1b[0m/'
}

__svn_st()
{
    OUT_MSG=""; [ "$(svn st 2> /dev/null | awk '{print $1}' |grep M |wc -l)" -ne "0" ] && OUT_MSG="[*]"
    echo $OUT_MSG
}

__git_remote_revision()
{
echo $(git ls-remote $(git rev-parse --abbrev-ref @{u} | sed 's/\// /g') | cut -f1)

}

__git_st()
{
    #echo $(git rev-parse HEAD)
    #echo $(__git_remote_revision)
    [ $(git rev-parse HEAD) = $(__git_remote_revision) ] && echo 0 || echo 1
}

__git_st_wrp()
{
    [ $(__git_st 2>/dev/null) == 1 ] && echo [⚡] || echo ""
}

#⚡
__currentTTY()
{
#echo `tty | sed -e "s:/dev/::"`
temp=$(tty) ; echo ${temp:5}
}

__printor()
{
    TERMCOLS=$(tput cols)

    MSG=${1}
    COLOR=${2}
    MSGLNGTH=${#MSG}
    STARTLINE=$(printf "%-$((${TERMCOLS}/2 - ${MSGLNGTH}/2))s" "")
    STLNLNGTH=${#STARTLINE}
    ENDLINE=$(printf "%-$((${TERMCOLS} - (${STLNLNGTH} + ${MSGLNGTH})))s" "")

    echo $ORANGE"${STARTLINE// / }$COLOR${MSG}$NC$ORANGE${ENDLINE// / }"$NC
}

__blockprintor()
{
    BPMSG=${1}
    BPCOLOR=${2}
    BPDATE=`date -R`

    BPMSGLNGTH=${#BPMSG}
    BPDATELNGTH=${#BPDATE}

    BPMSGSPACEREXT=""
    BPDATESPACEREXT=""

    if [ $BPMSGLNGTH -ge $BPDATELNGTH ]; then
        BPHEADERLNGTH=${BPMSGLNGTH}

    else
        BPHEADERLNGTH=${BPDATELNGTH}
        if [  $(expr ${BPMSGLNGTH} % 2) -eq 0 ]; then
            BPMSGSPACEREXT=" "
        fi
    fi


        if [  $(expr ${BPHEADERLNGTH} % 2) -eq 0 ]; then
            BPDATESPACEREXT=" "
        fi

    BPHEADERLINE=`printf -v BPHEADERLINETMP "%-$((${BPHEADERLNGTH}))s" ' '; echo "${BPHEADERLINETMP// /─}"`
    BPDATESPACER=$(printf "%-$(( (${BPHEADERLNGTH}-${BPDATELNGTH})/2 ))s" "")
    BPMSGSPACER=$(printf "%-$(( (${BPHEADERLNGTH}-${BPMSGLNGTH})/2 ))s" "")

    __printor "┌─${BPHEADERLINE}─┐" ${BPCOLOR}
    __printor "│ ${BPMSGSPACER// / }${BPMSG}${BPMSGSPACER// / }${BPMSGSPACEREXT} │" ${BPCOLOR}
    __printor "│ ${BPDATESPACER// / }${BPDATE}${BPDATESPACER// / }${BPDATESPACEREXT} │" ${BPCOLOR}
    __printor "└─${BPHEADERLINE}─┘" ${BPCOLOR}
}

__printfulline()
{
    TERMCOLS=$(tput cols)
    FULLLINE=$(printf "%-${TERMCOLS}s" "*")
    __printor "${FULLLINE// /*}"
}

# compressed file expander from github.com/zanshin
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
ex() {
  if [[ -e $1 ]]; then
    case $1 in
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz) tar xvzf $1;;
      *.tar.xz) tar xvJf $1;;
      *.tar.lzma) tar --lzma xvf $1;;
      *.bz2) bunzip $1;;
      *.rar) unrar $1;;
      *.gz) gunzip $1;;
      *.tar) tar xvf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *.7z) 7z x $1;;
      *.dmg) hdiutul mount $1;; # mount OS X disk images
      *) echo "'$1' cannot be extracted via >ex<";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show how much RAM application uses.  from github.com/zanshin
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
# from https://github.com/paulmillr/dotfiles
function ram() {
  local sum
  local items
  local app="$1"
  if [[ -z "$app" ]]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}


