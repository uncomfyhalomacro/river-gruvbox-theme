#!/usr/bin/env bash

RISTATE_LOG="$HOME/ristate.log"

ristate -vt -t -w > $RISTATE_LOG &

# Create a while loop that checks the status of the log
# If log reaches 300 lines, then restart ristate
while true
do
    RISTATE_STATE=$(pgrep ristate)
    
    sleep 20
    if [[ $RISTATE_STATE -eq null ]]; then
        ristate -vt -t -w > $RISTAGE_LOG &
    else
        if [[ $(wc -l $RISTATE_LOG) -ge 300 ]]; then
            pkill ristate
        else
            continue
        fi
    fi
done
