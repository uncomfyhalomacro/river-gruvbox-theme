#!/bin/sh

###############
# Keybindings #
###############
# Use the "logo" key as the primary modifier
mod="Mod4"

# Set your terminal emulator - foot
term=footclient

# LOCK ME UP  HERE TOO BUT BE ACTIVE
riverctl map normal $mod "equal" spawn 'swaylock -f -i $HOME/.config/river/backgrounds/background.jpg'
riverctl map normal $mod I spawn "foot -T 'Firefox Profiles' -c $HOME/.config/foot/foot-thicc.ini -w '350x200' -a firefoxprofile $HOME/.config/river/firefox.sh"
riverctl map normal $mod O spawn "chromium --enable-features=UseOzonePlatform --ozone-platform=wayland"
riverctl map normal "Mod1" "space" spawn "foot -T 'Desktop Launcher' -c $HOME/.config/foot/foot-thicc.ini -w '500x800' -a desktops $HOME/.config/river/desktop.sh foot"
riverctl map normal $mod U spawn "foot -T 'Open Site' -c $HOME/.config/foot/foot-thicc.ini -w '300x300' -a desktops $HOME/.config/river/browser.sh"
riverctl map normal $mod+Shift U spawn "foot -T 'Launcher' -c $HOME/.config/foot/foot-thicc.ini -w '200x400' -a launcher $HOME/.config/river/launcher.sh"
riverctl map normal $mod T spawn "foot -f 'JuliaMono:size=7, Hack Nerd Font:size=7, Monofur Nerd Font:size=7, Noto Color Emoji:size=7' -a erudite $HOME/.config/river/erudite.sh"
riverctl map normal $mod "slash" spawn "foot -T 'Library' -c $HOME/.config/foot/foot-thicc.ini -w '1200x600' -f 'JuliaMono:size=6, Hack Nerd Font:size=8, Monofur Nerd Font:size=8, Noto Color Emoji:size=8' -a library $HOME/.config/river/book.sh"

riverctl map normal $mod C spawn "foot -T 'Clipboard Manager' -c $HOME/.config/foot/foot-thicc.ini -w '700x400' -a clipfoot $HOME/.config/river/clipboardmanager.sh"
riverctl map normal $mod "bracketright" spawn "$HOME/.local/bin/colorpicker.sh"
# Screenshot scripts
riverctl map normal "None" Print spawn $HOME/.local/bin/mygrimshot.sh
riverctl map normal "$mod" Print spawn '$HOME/.local/bin/mygrimshot.sh area'

# Mod+Shift+Return to start an instance of foot (https://codeberg.org/dnkl/foot)
riverctl map normal $mod+Shift Return spawn $term

riverctl map normal $mod "backslash" spawn 'wshowkeys -b "#000000" -f "#ffffff" -s "#fcff00" -F "Hack Nerd Font 15" -t 1 -a "bottom" -a "right" -m 50'
riverctl map normal $mod+Shift "backslash" spawn "pkill wshowkeys"
    
#############################
# Views and Window Controls #
#############################
# Mod+Q to close the focused view
riverctl map normal $mod+Shift Q close

# Mod+E to exit river
riverctl map normal $mod+Shift E exit

# Mod+J and Mod+K to focus the next/previous view in the layout stack
riverctl map normal $mod J focus-view next
riverctl map normal $mod K focus-view previous

# Mod+Space to toggle float
riverctl map normal $mod Space toggle-float

# Mod+F to toggle fullscreen
riverctl map normal $mod F toggle-fullscreen

# Mod+Shift+J and Mod+Shift+K to swap the focused view with the next/previous
# view in the layout stack
riverctl map normal $mod+Shift J swap next
riverctl map normal $mod+Shift K swap previous

# Mod+Period and Mod+Comma to focus the next/previous output
riverctl map normal $mod Period focus-output next
riverctl map normal $mod Comma focus-output previous

# Mod+Shift+{Period,Comma} to send the focused view to the next/previous output
riverctl map normal $mod+Shift Period send-to-output next
riverctl map normal $mod+Shift Comma send-to-output previous

# Mod+Return to bump the focused view to the top of the layout stack
riverctl map normal $mod Return zoom

# Back to previous tag
riverctl map normal $mod B send-to-previous-tags

# Back and forth previous tags 
riverctl map normal $mod+Shift B focus-previous-tags


# Mod + Left Mouse Button to move views
riverctl map-pointer normal $mod BTN_LEFT move-view

# Mod + Right Mouse Button to resize views
riverctl map-pointer normal $mod BTN_RIGHT resize-view

########################
# Tags and Tag Controls #
########################
for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1))) # Ask ifreund why he does this. It makes sense though.

    # Mod+[1-9] to focus tag [0-8]
    riverctl map normal $mod "${i}" set-focused-tags $tags

    # Mod+Shift+[1-9] to tag focused view with tag and also move window with it. [0-8]
    # I made it like this because I want to move the stuff and the views at the same time. weird hack
    riverctl map normal $mod+Shift "${i}" spawn "riverctl set-view-tags $tags; riverctl set-focused-tags $tags"  
    riverctl map normal $mod+Control "${i}" toggle-focused-tags $tags

    # Mod+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal $mod+Shift+Control "${i}" toggle-view-tags $tags

    #########################
    # Experimenting Numlock #
    ################################
    # Mod+[1-9] to focus tag [0-8] #
    ################################
    numkeysyms=("" "End" "Down" "Next" "Left" "Begin" "Right" "Home" "Up" "Prior")
    riverctl map normal $mod "KP_$i" set-focused-tags $tags
    riverctl map normal $mod "KP_${numkeysyms[${i}]}" set-focused-tags $tags
    riverctl map normal $mod+Shift "KP_${numkeysyms[${i}]}" spawn "riverctl set-view-tags $tags; riverctl set-focused-tags $tags"  
    riverctl map normal $mod+Control "KP_$i" toggle-focused-tags $tags
    riverctl map normal $mod+Control "KP_${numkeysyms[${i}]}" toggle-focused-tags $tags
    riverctl map normal $mod+Shift+Control "KP_${numkeysyms[${i}]}" toggle-view-tags $tags

    riverctl map locked $mod "KP_$i" set-focused-tags $tags
    riverctl map locked $mod "KP_${numkeysyms[${i}]}" set-focused-tags $tags
    riverctl map locked $mod+Shift "KP_${numkeysyms[${i}]}" spawn "riverctl set-view-tags $tags; riverctl set-focused-tags $tags"  
    riverctl map locked $mod+Control "KP_$i" toggle-focused-tags $tags
    riverctl map locked $mod+Control "KP_${numkeysyms[${i}]}" toggle-focused-tags $tags
    riverctl map locked $mod+Shift+Control "KP_${numkeysyms[${i}]}" toggle-view-tags $tags
    ######################################################################################
done

# One hidden tag for now acting as a scratchpad
riverctl map normal $mod S set-focused-tags 512
riverctl map normal $mod+Shift S spawn "riverctl set-view-tags 512; riverctl set-focused-tags 512"
riverctl map normal $mod+Control S toggle-focused-tags 512
riverctl map normal $mod+Shift+Control S toggle-view-tags 512

# One hidden tag for now acting as a work space
riverctl map normal $mod W set-focused-tags 1024
riverctl map normal $mod+Shift W spawn "riverctl set-view-tags 1024; riverctl set-focused-tags 1024"
riverctl map normal $mod+Control W toggle-focused-tags 1024
riverctl map normal $mod+Shift+Control W toggle-view-tags 1024

##############################
# One private tag not listed #
##############################
riverctl map normal $mod P set-focused-tags 2048
riverctl map normal $mod+Shift P spawn "riverctl set-view-tags 2048; riverctl set-focused-tags 2048"
riverctl map normal $mod+Control P toggle-focused-tags 2048
riverctl map normal $mod+Shift+Control P toggle-view-tags 2048

riverctl map normal $mod KP_Subtract set-focused-tags 2048
riverctl map normal $mod+Shift KP_Subtract spawn "riverctl set-view-tags 2048; riverctl set-focused-tags 2048"
riverctl map normal $mod+Control KP_Subtract toggle-focused-tags 2048
riverctl map normal $mod+Shift+Control KP_Subtract toggle-view-tags 2048

riverctl map locked $mod KP_Subtract set-focused-tags 2048
riverctl map locked $mod+Shift KP_Subtract spawn "riverctl set-view-tags 2048; riverctl set-focused-tags 2048"
riverctl map locked $mod+Control KP_Subtract toggle-focused-tags 2048
riverctl map locked $mod+Shift+Control KP_Subtract toggle-view-tags 2048
########################################################################

##########################
# Mod+0 to focus all tags#
################################################
# Mod+Shift+0 to tag focused view with all tags#
################################################
all_tags=$(((1 << 32) - 1))
riverctl map normal $mod 0 set-focused-tags $all_tags
riverctl map normal $mod+Shift 0 set-view-tags $all_tags
riverctl map normal $mod "KP_0" set-focused-tags $all_tags
riverctl map normal $mod+Shift "KP_Insert" set-view-tags $all_tags
riverctl map locked $mod "KP_0" set-focused-tags $all_tags
riverctl map locked $mod+Shift "KP_Insert" set-view-tags $all_tags
###################################################################
# Various media key mapping examples for both normal and locked mode which do
# not have a modifier
for mode in normal locked
do
    # Eject the optical drive
    riverctl map $mode None XF86Eject spawn eject -T
    
    # Touchpad
    touchpad_device="1267:12632:ELAN050A:01_04F3:3158_Touchpad"
    riverctl input $touchpad_device events enabled
    riverctl input $touchpad_device natural-scroll enabled
    riverctl input $touchpad_device tap enabled
    riverctl input $touchpad_device tap-button-map left-right-middle
    riverctl input $touchpad_device drag enabled
    riverctl input $touchpad_device drag-lock enabled

    # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
    riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
    riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
    riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

    # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
    riverctl map $mode None XF86AudioMedia spawn 'playerctl -p spotify play-pause'
    riverctl map $mode None XF86AudioPlay  spawn 'playerctl -p spotify play-pause'
    riverctl map $mode None XF86AudioPrev  spawn 'playerctl -p spotify previous'
    riverctl map $mode None XF86AudioNext  spawn 'playerctl -p spotify next'

    # Control screen backlight brighness with light (https://github.com/haikarainen/light)
    riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl s +5%'
    riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl s 5%-'

done
 
#########################
# Float and CSD Filters #
#########################
# Set repeat rate
riverctl set-repeat 50 300

# Set app-ids of views which should float
riverctl float-filter-add app-id "gedit"
riverctl float-filter-add app-id "swappy"
riverctl float-filter-add app-id "launcher"
riverctl float-filter-add app-id "desktops"
riverctl float-filter-add app-id "gnome-calculator"
riverctl float-filter-add app-id "library"
riverctl float-filter-add app-id "firefoxprofile"
riverctl float-filter-add app-id "clipfoot"
riverctl float-filter-add title "Picture-in-Picture"

# Set app-ids of views which should use client side decorations
riverctl csd-filter-add app-id "gedit"
riverctl csd-filter-add app-id "swappy"
riverctl csd-filter-add app-id "desktops"
riverctl csd-filter-add app-id "launcher"
riverctl csd-filter-add app-id "firefoxprofile"
riverctl csd-filter-add app-id "library"
riverctl csd-filter-add app-id "clipfoot"
riverctl csd-filter-add app-id "gnome-calculator"


###########
# Layouts #
###########
# Mod+D switch layout to user-defined default
riverctl map normal $mod D spawn $HOME/.config/river/default_layout.sh

# Mod+G switch to layout master grid
riverctl map normal $mod G spawn $HOME/.config/river/master_grid.sh

# Mod+M switch to layout monocle
riverctl map normal $mod M spawn $HOME/.config/river/monocle.sh

# Mod+Shift+R user-defined default
riverctl map normal $mod+Shift R send-layout-cmd stacktile "reset"

# Mod+, switch to layour master stack
riverctl map normal $mod comma spawn $HOME/.config/river/master_stack.sh

# Mod+H and Mod+L to decrease/increase the main ratio of stacktile
riverctl map normal $mod H send-layout-cmd stacktile "primary_ratio -0.05"
riverctl map normal $mod L send-layout-cmd stacktile "primary_ratio +0.05"

# Mod+H and Mod+L to decrease/increase the main ratio of stacktile
riverctl map normal $mod+Control H send-layout-cmd stacktile "secondary_ratio -0.05"
riverctl map normal $mod+Control L send-layout-cmd stacktile "secondary_ratio +0.05"

# Mod+Shift+H and Mod+Shift+L to increment/decrement the main_count value of stacktile.
riverctl map normal $mod+Shift H send-layout-cmd stacktile "primary_count -1"
riverctl map normal $mod+Shift L send-layout-cmd stacktile "primary_count +1"

# Mod+{Up,Right,Down,Left} to change layout orientation
riverctl map normal $mod Up    send-layout-cmd stacktile "primary_position top"
riverctl map normal $mod Right send-layout-cmd stacktile "primary_position right"
riverctl map normal $mod Down  send-layout-cmd stacktile "primary_position bottom"
riverctl map normal $mod Left  send-layout-cmd stacktile "primary_position left"

# Send all windows to primary area
riverctl map normal $mod A     send-layout-cmd stacktile "all_primary toggle"

# Mod+Alt+{H,J,K,L} to move views
riverctl map normal $mod+Mod1 H move left 100
riverctl map normal $mod+Mod1 J move down 100
riverctl map normal $mod+Mod1 K move up 100
riverctl map normal $mod+Mod1 L move right 100

# Mod+Alt+Control+{H,J,K,L} to snap views to screen edges
riverctl map normal $mod+Mod1+Control H snap left
riverctl map normal $mod+Mod1+Control J snap down
riverctl map normal $mod+Mod1+Control K snap up
riverctl map normal $mod+Mod1+Control L snap right

# Mod+Alt+Shif+{H,J,K,L} to resize views
riverctl map normal $mod+Mod1+Shift H resize horizontal -100
riverctl map normal $mod+Mod1+Shift J resize vertical 100
riverctl map normal $mod+Mod1+Shift K resize vertical -100
riverctl map normal $mod+Mod1+Shift L resize horizontal 100

# Stacktile
riverctl default-layout stacktile
riverctl spawn "stacktile --per-tag-config --primary-count 2  --secondary-count 3 --primary-sublayout stack --primary-position left --primary-ratio 0.55 --outer-padding 0 --inner-padding 1 --secondary-sublayout rows --secondary-ratio 0.5 --remainder-sublayout stack" 
# River will send the process group of the init executable SIGTERM on exit.

########
# Misc #
########
# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough

# Mod+F11 to enter passthrough mode
riverctl map normal $mod F11 enter-mode passthrough

# Mod+F11 to return to normal mode
riverctl map passthrough $mod F11 enter-mode normal
