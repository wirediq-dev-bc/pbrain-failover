#!/bin/bash

WHEREAMI=$(readlink -f $0)
PROGNAME=${WHEREAMI##*/}

sh_c='sh -c'
ECHO=${ECHO:-}
[ "$ECHO" ] && sh_c='echo'

QUERY_SERVER=${QUERY:-192.168.100.1}

Usage () {
    cat >&2 <<- EOF
usage: $PROGNAME 
EOF
}

Error () {
    echo -e "-${PROGNAME%.*} error: $1\n" > /dev/stderr
    exit 1
}

rsh_office_dhcp () {
    if ! $sh_c "rsh root@$QUERY_SERVER 'cat /tmp/dhcp.leases'"; then
        Error 'fatal dhcp.leases dump attempt'
    fi
}

rsh_office_dhcp

