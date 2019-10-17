#!/bin/bash

##yo, include dat file in ur .bashrc

##[==========================================================================]##
##
source_file()
{
    [ -r "${1}" ] && source "${1}"
}

source_dat()
{
    [ -r "${1}" ] && source "${1}"
}

##=-                                                                        -=##
embrace()
{
    if [ "$1" = "--help" ] || [ "$#" -eq 0 ]; then
        echo "USAGE: embrace STR [OPENING_BRACE] [CLOSING_BRACE]"
        return 0
    fi

    echo -e "${2}${1}${3}"
}


##=-                                                                        -=##
embracedat()
{
    STR=$(embrace "${1}" '[ '  ' ]')
    echo -e "$STR"
}

##[==========================================================================]##
## svn
__ddiff()
{
    svn diff |sed 's/^-/\x1b[30m\x1b[41m-/;s/^+/\x1b[30m\x1b[42m+/;s/^@/\x1b[30m\x1b[43m@/;s/$/\x1b[0m/'
}

##[==========================================================================]##
__svn_st()
{
    OUT_MSG=""; [ "$(svn st 2> /dev/null | awk '{print $1}' |grep M |wc -l)" -ne "0" ] && OUT_MSG="[*]"
    echo $OUT_MSG
}

##[==========================================================================]##
__uptime()
{
    echo $(uptime --pretty | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')
}

##[==========================================================================]##
__loadavg()
{
    echo $(awk '{print $1" "$2" "$3}' < /proc/loadavg)
}

##[==========================================================================]##
__git_remote_revision()
{
echo $(git ls-remote $(git rev-parse --abbrev-ref @{u} | sed 's/\// /g') | cut -f1)

}

##[==========================================================================]##
__git_st()
{
    #echo $(git rev-parse HEAD)
    #echo $(__git_remote_revision)
    [ $(git rev-parse HEAD) = $(__git_remote_revision) ] && echo 0 || echo 1
}

##[==========================================================================]##
__git_st_wrp()
{
    [ $(__git_st 2>/dev/null) == 1 ] && echo [⚡] || echo ""
}

##[==========================================================================]##
## prints TTY name of current term.
__currentTTY()
{
    #echo `tty | sed -e "s:/dev/::"`
    temp=$(tty) ; echo ${temp:5}
}

##=-                                                                        -=##
mek_laine()
{
    FILLER=${2}
    [ -z "${FILLER}" ] && FILLER=" "
    pad=$(printf "%${1}s" "");pad=${pad// /${FILLER}};echo -en "$pad"
}

##[==========================================================================]##
## prints MSG(1) of COLOR(2) in middle of term line.
__printor()
{
    local TERMCOLS=$(tput cols)

    local MSG=${1}
    local COLOR=${2}
    local MSGLNGTH=${3}
    if [[ ${MSGLNGTH} == "" ]]; then
        MSGLNGTH=${#MSG}
    fi
    local STARTLINE=$(mek_laine "$((${TERMCOLS}/2 - ${MSGLNGTH}/2))")
    local STLNLNGTH=${#STARTLINE}
    local ENDLINE=$(mek_laine "$((${TERMCOLS} - (${STLNLNGTH} + ${MSGLNGTH})))")

    echo ${NC}"${STARTLINE}${COLOR}${MSG}${NC}${NC}${ENDLINE}"$NC
}

##[==========================================================================]##
## prints string.
__msgprintor()
{
    declare -a MSG=("$1")
    declare -a HEADER=("$3")
    __arrayprintor "MSG" "${2}" "HEADER"
}

##[==========================================================================]##
## prints array of strings.
__blockprintor()
{
    declare -a HEADER=("$3")
    __arrayprintor "${1}" "${2}" "HEADER"
}
##=-                                                                        -=##
function each()
{
  for dir in *; do

    if [ -d ${dir} ] && [ -r ${dir} ]; then
#        echo "${dir}:"
        cd $dir;RES="$?"
        if [ ${RES} -eq 0 ]; then
            $@
            cd ..
        fi
    fi
  done
}

##[==========================================================================]##
## prints array of strings.
__arrayprintor()
{

    declare -a BPMSG=("${!1}")
         # for a in ${!BPMSG[*]}; do ( echo ${BPMSG[$a]}) done;

    declare -a OUTARRAY=()
    local BPCOLOR=${2}

    local BPMAXMSGSPACER=

    for index in ${!BPMSG[*]};do
        local BPCURRENTMSGLNGTH=${#BPMSG[$index]}
        if [[ ${BPCURRENTMSGLNGTH} -gt ${BPMAXMSGSPACER} ]]; then
            BPMAXMSGSPACER=${BPCURRENTMSGLNGTH}
        fi
        OUTARRAY+=("${BPMSG[$index]}")
    done

    declare -a BPHEADERMSG=("${!3}")
    if [[ ${#BPHEADERMSG} -ge ${BPMAXMSGSPACER} ]]; then
        BPMAXMSGSPACER=${#BPHEADERMSG}
        local BPHEADERSPACERLINE=
    else
        local BPHEADERSPACERLINE=$(mek_laine "$((${BPMAXMSGSPACER} - ${#BPHEADERMSG}))" "━" )
    fi

    local BPSPACERLINE=$(mek_laine "${BPMAXMSGSPACER}" "━" )
    local BPHEADERLINE="${SOMON}${BPHEADERMSG}${SOMOF}${BPHEADERSPACERLINE}"

##===============================DEBUG TRACE =================================##
    # echo "[ MAX MSG SPACER:           '${BPMAXMSGSPACER}' ]"
    # echo "[ HEADER SPACER LINE LNGTH: '${#BPHEADERSPACERLINE}' ]"
    # echo "[ HEADER MSG LINE LNGTH:    '${#BPHEADERMSG}' ]"
    # echo "[ SPACER LINE LNGTH:        '${#BPSPACERLINE}' ]"
    # echo "[ HEADER LINE LNGTH:        '${#BPHEADERLINE}' ]"
##[==========================================================================]##

    OUT=${OUT}$(__printor "┏━${BPHEADERLINE}━┓" \
                          "${BPCOLOR}" \
                          "$(expr ${#BPHEADERMSG} + ${#BPHEADERSPACERLINE} + 4)" \
               )

    for index in ${!OUTARRAY[*]};do
        local BPMSGSPACEREXT=""
        local BPCURRENTMSGLNGTH=${#OUTARRAY[$index]}
        local BPMSGSPACER=$(mek_laine $(( (${BPMAXMSGSPACER}-${BPCURRENTMSGLNGTH})/2 )) )

        if [  $(expr $(expr ${BPMAXMSGSPACER} - ${BPCURRENTMSGLNGTH}) % 2) -eq 1 ]; then
            BPMSGSPACEREXT=" "
        fi

##===============================DEBUG TRACE =================================##
        # echo "[ CURRENT MSG LNGTH:   '${BPCURRENTMSGLNGTH}' ]"
        # echo "[ TOTAL SPACER LNGTH:  '$(expr ${BPMAXMSGSPACER} - ${BPCURRENTMSGLNGTH})' ]"
        # echo "[ HALF SPACER LNGTH:   '${#BPMSGSPACER}' ]"
        # echo "[ MSG SPACEREXT LNGTH: '${#BPMSGSPACEREXT}' ]"
##[==========================================================================]##

        local CURRENT_LINE="${BPMSGSPACER}${OUTARRAY[$index]}${BPMSGSPACER}${BPMSGSPACEREXT}"
        OUT=${OUT}$(__printor "┃ ${CURRENT_LINE} ┃" ${BPCOLOR})
    done

    OUT=${OUT}$(__printor "┗━${BPSPACERLINE}━┛" ${BPCOLOR})
    echo -e "${OUT}"
}

##[==========================================================================]##
__printfulline()
{
    # TERMCOLS=$(tput cols)
    # FULLLINE=$(printf "%-${TERMCOLS}s" "*")
    # __printor "${FULLLINE// /*}"
    mek_laine "$(tput cols)" "*"
}


##[==========================================================================]##
## fill spaces for str up 2 max length
__fillstr()
{
    MAXLEN=${1}
    STR=${2}
    while [ ${#STR} -lt ${MAXLEN} ]; do
        STR=" "${STR}
    done
    echo "${STR}"
}

##[==========================================================================]##
##=-                                                                        -=##
## pack dat
packdat()
{
    CMND=$1
    SRC_PATH=$2
    SUFIX=$3
    RES=1
    if [[ -e $SRC_PATH ]]; then
        BEKAP_NAME="$(basename ${SRC_PATH}).$(date +%Y%m%d%H%M%S)${SUFIX}"
        $CMND ./${BEKAP_NAME} ${SRC_PATH};RES=$?
    else
        echo "path '$SRC_PATH' is not valid"
    fi
    if [ $RES -ne 0 ]; then
        echo "ERROR"
    else
        echo -e "\nBEKAP_NAME: $BEKAP_NAME $(du -hs ${BEKAP_NAME} | cut  -f 1)"
    fi
}

##=-                                                                        -=##
## tar dat
tardat()
{
    packdat "tar cvzf" "$1" ".tar.gz"
}

##=-                                                                        -=##
## zip dat
zipdat()
{
    packdat "zip -r" "$1" ".zip"
}

##=-                                                                        -=##
kreeptdat()
{
    SUFIX=".kreept.zip"
    SRC_PATH="${1}"
    BEKAP_NAME="$(basename ${SRC_PATH}).$(date +%Y%m%d%H%M%S)${SUFIX}"

    tar cf - "${SRC_PATH}" | zip -1 -e "${BEKAP_NAME}" -
}

##=-                                                                        -=##
dekreeptdat()
{
    SRC_PATH="${1}"
    unzip -p ${SRC_PATH} | tar xf -
}

##=-                                                                        -=##
__lnsafe_usage()
{
    echo '[II] USAGE: '
    echo '    '${1}' SRC DST '
    echo
}
##[================]##
## replaces target to bekap if target exists, makes link from src to target.
lnsafe()
{
    if [ "$#" -ne 2 ]; then
        echo "[EE] [ Illegal number of parameters ]"
        echo '[II] [ Stay safe, stay legal ]'
        __lnsafe_usage ${FUNCNAME}
        return 1
    fi

    SRCPATH=${1}
    DSTPATH=${2}
    BEKAPPATH="${DSTPATH}.$(date +%d%m%Y%H%M%S).bekap"

    RESULT=1

    if [ -e ${SRCPATH} ]; then
        RESULT=0
    else
        if [ -L ${SRCPATH} ]; then
           RESULT=0
        fi
    fi

    if [ "..${RESULT}" != "..0" ];then
        echo "[EE] [ SRC not exists ]"
        __lnsafe_usage ${FUNCNAME}
        return 2
    fi

    RESULT=0

    if [ -e ${DSTPATH} ]; then
        echo '[ target exists: '${DSTPATH}' ]'
        mv ${DSTPATH} ${BEKAPPATH}; RESULT=$?
        if [ "..${RESULT}" = "..0" ];then
            echo '[ bekap created: '${BEKAPPATH}' ]'
        fi
    else
        if [ -L ${DSTPATH} ]; then
            echo '[ target is symlink: '${DSTPATH}' ]'
            mv ${DSTPATH} ${BEKAPPATH}; RESULT=$?
            if [ "..${RESULT}" = "..0" ];then
                echo '[ bekap created: '${BEKAPPATH}' ]'
            fi
        fi
    fi



    if [ "..${RESULT}" = "..0" ]; then
        ln -s ${SRCPATH} ${DSTPATH}
        echo '[ link created: '${DSTPATH}' ]'
    fi

    return 0
}

##[==========================================================================]##
err()
{
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

## 3p_FUNCTIONS
source_dat "${HOME}/.bash_3rd_party"
