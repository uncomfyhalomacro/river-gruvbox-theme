#!/bin/sh

while true; do
    status=$(ristate -w | jq '.title' -r & pkill ristate)
    echo "tag|string|$status"
    echo ""
    sleep 1
done
