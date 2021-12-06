#!/bin/sh 

shopt -s lastpipe

clipman pick -t STDOUT | fzf -e -i --prompt="clipboard: "  | read -r hmm

[ -z "${hmm}" ] && exit

command="wl-copy \"${hmm}\""

setsid /bin/sh -c "${command}" >&/dev/null &
sleep 0.3




