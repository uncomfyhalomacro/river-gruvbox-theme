#!/usr/bin/env bash

RISTATE_LOG="$HOME/ristate.log"

ristate -vt -t -w > $RISTATE_LOG &

# Create a while loop that checks the status of the log
# If log reaches 300 lines, then restart ristate
while true
do
    RISTATE_STATE=$(pgrep ristate)
    RISTATE_LOG_LINES=$(wc -l $RISTATE_LOG | awk '{ print $1 }')
    sleep 10s
    if [[ ! $RISTATE_STATE -eq null ]]; then
        ristate -vt -t -w > $RISTAGE_LOG &
    else
        if [[ $RISTATE_LOG_LINES -ge 10 ]]; then
            pkill ristate
        else
            continue
        fi
    fi
done
