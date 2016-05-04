
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
