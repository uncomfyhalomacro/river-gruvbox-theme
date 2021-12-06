#!/usr/bin/env bash

browser=/usr/bin/firefox 

sites=(
    "personal     wayland-protocols   https://gitlab.freedesktop.org/wayland/wayland-protocols/"
    "personal     julia               https://julialang.org" 
    "personal     github              https://github.com"
    "personal     river               https://github.com/riverwm/river"
    "personal     netflix             https://netflix.com"
    "personal     codeberg            https://codeberg.org"
    "personal     foot                https://codeberg.org/dnkl/foot"
    "school       scholar             https://scholar.google.com"
    "school       classroom           https://classroom.google.com"
	"school       MOLE                https://online.msuiit.edu.ph/moodle"
    "personal     everything-wayland  https://wayland.app/protocols/"
    "social       r/julia             https://reddit.com/r/Julia"
    "social       twitter             https://twitter.com/"
    "social       facebook            https://fb.me"
    "personal     archwiki            https://wiki.archlinux.org"
    "personal     openSUSE            https://opensuse.github.io/openSUSE-docs-revamped-temp"
    "personal     odysee              https://odysee.com"
)

shopt -s lastpipe

for site in "${sites[@]}"
do
    echo "${site}" | awk '{print $2}'
done | sort | fzf -d' ' -e -i --prompt="site: " | read -r name 

[ -z "${name}" ] && exit 1 

for site in "${sites[@]}"
do 
    _name="$(echo "${site}" | awk '{print $2}')"
    if [ "${_name}" == "${name}" ]
    then

        url="$(echo "${site}" | awk '{print $3}')"
        firefoxprofile="$(echo "${site}" | cut -d' ' -f1)"
    fi 
done

[ -z "${url}" ] && exit 1 

command="${browser} -p ${firefoxprofile} \"${url}\""

#riverctl spawn "source $HOME/.bashrc; ${command}"
setsid /bin/sh -c "${command}" >&/dev/null &
sleep 0.3
