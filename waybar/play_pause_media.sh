#!/usr/bin/env bash
player_status=$(playerctl -p spotify status)
if [[ $player_status = "Paused" ]]
then
    playerctl play
elif [[ $player_status = "Playing" ]]
then
    playerctl pause
else
    echo -e "Spotify not running"
fi

