#!/usr/bin/env bash
# Launcher for executables in $PATH

shopt -s lastpipe
source ~/.bashrc
IFS=$'\n' read -r -d '' -a desktops <<< "$(find /usr/share/applications/ $HOME/.local/share/applications/ $HOME/.local/share/flatpak/exports/share/applications/ $HOME/.var/app/com.valvesoftware.Steam/Desktop -name "*.desktop" 2> /dev/null)"

for i in "${desktops[@]}"; do echo "$(cat "${i}" | awk -F: '/^Name=/{sub(/^Name=/, ""); print; exit}')" ; done | sort | uniq | fzf -e -i --prompt='launch: ' | read -r cmd
for i in "${desktops[@]}"
do
    if grep -Fxq "Name=${cmd}" "${i}"
    then
        Exec="$(cat "${i}" | awk -F: '/^Exec=/{sub(/^Exec=/,""); print; exit}' | sed -E 's/%(U|F|u)//g')"
        Terminalorno="$(cat "${i}" | awk '/^Terminal=/{sub(/^Terminal=/,""); print}')"
        [ -z "${Exec}" ] && exit
        if [ "${Terminalorno}" = "true" ]
        then
            riverctl spawn "source ~/.bashrc; ${1} ${Exec}"
        else
            riverctl spawn "source ~/.bashrc; ${Exec}"
        fi
        break
    fi
done



    
