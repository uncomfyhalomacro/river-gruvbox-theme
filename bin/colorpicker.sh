#!/usr/bin/env bash

shopt -s lastpipe 

grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n +2 | awk '{print $3}' | read -r color

/bin/wl-copy "${color}"

exec notify-send --urgency "critical" "Hex Color: ${color}"
