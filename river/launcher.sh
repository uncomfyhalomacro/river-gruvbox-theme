#!/usr/bin/env bash
# Launcher for executables in $PATH

shopt -s lastpipe
source ~/.bashrc
IFS=: read -ra path <<< "$PATH"

[ -x "$(which flatpak)" ] && IFS=$'\n' read -r -d '' -a flatapps <<< "$(flatpak list --columns=application | tail -n +1)"

[ -x "$(which flatpak)" ] && for i in "${flatapps[@]}"
do
    flatrun=("${flatrun[@]}" "flatpak run ${i}")
done

for p in "${path[@]}"
do
    frompaths=("${frompaths[@]}" "$(ls ${p})")
done

allapps=("${frompaths[@]}" "${flatrun[@]}")

for e in "${allapps[@]}"
do 
    echo "$e"
done | uniq | sort | fzf -e -i --prompt='launch: ' | read -r cmd

[ -z "${cmd}" ] && exit

setsid /bin/sh -c "${cmd}" >&/dev/null &
sleep 0.3

