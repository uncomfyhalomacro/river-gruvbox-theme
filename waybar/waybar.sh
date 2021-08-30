#!/usr/bin/env bash

killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar --config=$HOME/.config/waybar/config --style=$HOME/.config/waybar/style.css
