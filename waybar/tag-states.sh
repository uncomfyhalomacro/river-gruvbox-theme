#!/usr/bin/env bash


RISTATE_LOG="$HOME/ristate.log"
while true
do
    sleep 10s
    if [[ $(pgrep -x ristate) -eq null ]]; then
        ristate -vt -t -w > $RISTAGE_LOG &
		continue
    else
    	RISTATE_LOG_LINES=$(wc -l $RISTATE_LOG | awk '{ print $1 }')
        if [[ $RISTATE_LOG_LINES -ge 10 ]]; then
            pkill ristate
			continue
        else
            continue
        fi
    fi
done
