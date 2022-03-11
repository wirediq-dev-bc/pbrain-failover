#!/bin/bash

WHEREAMI=$(readlink -f $0)
PROGNAME=${WHEREAMI##*/}

sh_c='sh -c'
ECHO=${ECHO:-}
[ "$ECHO" ] && sh_c='echo'

REMOTE_HOST="$1"

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
    if ! rsh $REMOTE_HOST "(logread; logread -f) | grep -Ev 'fractel|ping|dhcp|dropbear'"; then
        Error "failed to logread $REMOTE_HOST"
    fi
}

if [ ! "$REMOTE_HOST" ]; then
    Error 'must provide ssh/config:host'
fi
main

