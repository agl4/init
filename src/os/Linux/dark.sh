#!/usr/bin/env bash

set -eu

# https://github.com/littleant/auto-darkmode-switcher/blob/main/auto-darkmode-switcher.sh

# Check current theme setting
current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)

# Strip the " and " symbols from the gsettings output
current_theme=${current_theme//\'/}

# Check if the current theme ends with '-dark' to determine if it's dark mode
if [[ "$current_theme" == *-dark ]]; then
    # Current theme is dark, change to light (strip '-dark' from theme name)
    light_theme="${current_theme%-dark}"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    gsettings set org.gnome.desktop.interface gtk-theme "$light_theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$light_theme"
    echo "Switched to Light theme"
else
    # Current theme is light, change to dark by appending '-dark'
    dark_theme="${current_theme}-dark"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "$dark_theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$dark_theme"
    echo "Switched to Dark theme"
fi
