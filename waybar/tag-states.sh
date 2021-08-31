#!/usr/bin/env bash


export RISTATE_LOG="$HOME/ristate.log"
while true
do
    sleep 2s
    if [[ $(pgrep -x ristate) -eq null ]]; then
        ristate -vt -t -w > $RISTATE_LOG &
		continue
    else
    	RISTATE_LOG_LINES=$(wc -l $RISTATE_LOG | awk '{ print $1 }')
        [[ $RISTATE_LOG_LINES -ge 10 ]] && pkill ristate
    fi
done
