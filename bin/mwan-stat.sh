#!/bin/bash

WHEREAMI=$(readlink -f $0)
PROGNAME=${WHEREAMI##*/}

sh_c='sh -c'
ECHO=${ECHO:-}
[ "$ECHO" ] && sh_c='echo'

REMOTE_HOST=${@:-'-B enx00e04ccfd5a root@10.1.10.1'}

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
    WHILE_BODY='while true; do clear; mwan3 interfaces; mwan3 connected; sleep 1; done'
    $sh_c "rsh '$REMOTE_HOST' '$WHILE_BODY'" | ccze -A
}

if [ ! "$REMOTE_HOST" ]; then
    Error 'must provide remote hostname'
fi

main

