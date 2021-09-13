#!/usr/bin/env bash

killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 2s; done
exec waybar
