#!/bin/bash

# The stupid mwan3 test manager

WHEREAMI=$(readlink -f $0)
PROGNAME=${WHEREAMI##*/}

sh_c='sh -c'
ECHO=${ECHO:-}
[ "$ECHO" ] && sh_c='echo'

MYIP='ipv4:\n\033[38;5;46m$(curl -s ifconfig.me)\033[00m\n'
PING_WAN1='eth0:\n\033[38;5;154m$(ping -W 1 -c 1 -I eth0 google.com)\033[00m\n'
PING_WAN3='eth2:\n\033[38;5;51m$(ping -W 1 -c 1 -I eth2 google.com)\033[00m\n'
PING_LTE='eth1.44:\n\033[38;5;202m$(ping -W 1 -c 1 -I eth1.44 google.com)\033[00m\n'

TEST_CMDS="${MYIP}\n${PING_WAN1}\n${PING_WAN3}\n${PING_LTE}"
REMOTE_HOST="$@"


Usage () {
    cat >&2 <<- EOF
usage: $PROGNAME REMOTE_HOSTNAME
EOF
}

Error () {
    echo -e "-${PROGNAME%.*} error: $1\n" > /dev/stderr
    exit 1
}

main () {
    WHILE_LOOP="while true; do echo -e \"$TEST_CMDS\"; sleep 1; clear; done"
    $sh_c "rsh $REMOTE_HOST '$WHILE_LOOP'"
}

[ "$REMOTE_HOST" ] || Error 'must provide a hostname'
main

