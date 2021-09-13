#!/bin/sh

killall -q mako
while pgrep -x mako >/dev/null; do sleep 1; done
exec mako
