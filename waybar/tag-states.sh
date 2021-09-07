#!/usr/bin/env bash


export RISTATE_LOG="$HOME/ristate.log"
while true
do
    ristate -vt -t -w > $RISTATE_LOG &
    sleep 30s
    killall -q ristate

done
