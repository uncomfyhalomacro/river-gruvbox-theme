#!/bin/sh

shopt -s lastpipe

DOC="$HOME/Documents"

find "$DOC" -name "*.pdf" | sort | fzf -e -i --prompt='read book: ' | read -r book

[ -z "${book}" ]  && exit

command="zathura \"$book\""
riverctl spawn "${command}"
