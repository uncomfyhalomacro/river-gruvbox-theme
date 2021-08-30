#!/bin/bash

echo -e "This will remove or overwrite your previous configurations, are you sure? y - confirm; any letter - to abort"

read -r answer

if [[ $answer == "y" ]] || [[ $answer == "Y" ]]; then

    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

    for i in {river,mako,waybar,foot}; do
        CONF_DIR="${HOME}/.config/${i}"
        if [ -d  "$CONF_DIR" ]; then
            BACKUP_DIR="$HOME"/.config/riverconfigbackup
            mkdir -p "$BACKUP_DIR"
            cp -frv "$CONF_DIR" "$BACKUP_DIR"
            rm -rf "$CONF_DIR"
            cp -frv "$SCRIPT_DIR"/"$i" "$CONF_DIR"
        else
            # Check if it is a symlink file
            if [ -h "$CONF_DIR" ]; then
                rm "$CONF_DIR"
                cp -rfv "$SCRIPT_DIR"/"$i" "$HOME"/.config 
            else
                cp -rfv "$SCRIPT_DIR"/"$i" "$HOME"/.config
            fi
        fi
    done
    echo "Copying very good and cool scripts :P"
    cp -fv "${SCRIPT_DIR}"/bin/* $HOME/.local/bin/
    echo "Done copying configs"
    sleep 2s
    echo "DONE"
else
    echo "Aborted"
    exit
fi
