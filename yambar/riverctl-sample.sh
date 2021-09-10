#!/bin/sh

if [[ $1 == "9" ]]; then
    riverctl set-focused-tags 1
else
	tag=$((1 << ($(expr $1) + 1)))
	riverctl set-focused-tags $tag
fi
    
