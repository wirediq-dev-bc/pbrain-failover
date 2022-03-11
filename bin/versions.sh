#!/bin/bash

WHEREAMI=$(readlink -f $0)
PROGNAME=${WHEREAMI##*/}

sh_c='sh -c'
ECHO=${ECHO:-}
[ "$ECHO" ] && sh_c='echo'

REMOTE_HOSTNAME="$1"


Usage () {
    cat >&2 <<- EOF
usage: $PROGNAME
EOF
}

Error () {
    echo -e "-${PROGNAME%.*} error: $1\n" > /dev/stderr
    exit 1
}

main () {
    FILENAMES=('os-release' 'openwrt_release' 'openwrt_version')
    {
        for filename in "${FILENAMES[@]}"; do
            filename="/etc/$filename"
            header="\033[38;5;201m>>> $filename\033[00m"
            $sh_c "rsh $REMOTE_HOSTNAME 'cat $filename'"
            echo
        done; 
    } | ccze -A
}

[ ! "$REMOTE_HOSTNAME" ] && 
    Error 'must provide remote hostname'
main

