#!/usr/bin/env bash

killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar --config=$HOME/.config/waybar/riverconfig --style=$HOME/.config/waybar/riverstyle.css
