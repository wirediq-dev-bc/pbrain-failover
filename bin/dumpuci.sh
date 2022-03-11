#!/bin/bash

WHEREAMI=$(readlink -f $0)
PROGNAME=${WHEREAMI##*/}

sh_c='sh -c'
ECHO=${ECHO:-}
[ "$ECHO" ] && sh_c='echo'

UCI_LOOP='{ for i in *; do echo -e "\n>>> uci show $i\n$(uci show $i)"; done; }'
EXECUTOR="cd /etc/config && $UCI_LOOP && echo"
HOST_ADDRESS="$1"; shift
HOST_USER="${1:-root}"


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
    if ! $sh_c "rsh ${HOST_USER}@${HOST_ADDRESS} '$EXECUTOR'"; then
        Error "$HOST_ADDRESS:\`uci show all\` failed"
    fi
}

main

