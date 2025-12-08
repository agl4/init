#!/usr/bin/env bash

set -eu

# https://github.com/littleant/auto-darkmode-switcher/blob/main/auto-darkmode-switcher.sh
# https://pastebin.com/SyPRXGCE

# Check current theme setting
current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)

# Strip the " and " symbols from the gsettings output
current_theme=${current_theme//\'/}

case $current_theme in
    Breeze*) dark_name=Dark ;;
    *) dark_name=dark ;;
esac

# Check if the current theme ends with '-dark' to determine if it's dark mode
if [[ "$current_theme" == *-$dark_name ]]; then
    # Current theme is dark, change to light (strip '-dark' from theme name)
    light_theme="${current_theme%-$dark_name}"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    gsettings set org.gnome.desktop.interface gtk-theme "$light_theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$light_theme"
    echo "Switched to Light theme"
else
    # Current theme is light, change to dark by appending '-dark'
    dark_theme="${current_theme}-$dark_name"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "$dark_theme"
    gsettings set org.gnome.desktop.wm.preferences theme "$dark_theme"
    echo "Switched to Dark theme"
fi

if [ -x /usr/bin/plasma-apply-colorscheme ] ; then
    CUR_SCHEME=$(plasma-apply-colorscheme --list-schemes | grep "current color scheme")
    case $CUR_SCHEME in
        *BreezeDark*)  plasma-apply-colorscheme BreezeLight  ;;
        *BreezeLight*) plasma-apply-colorscheme BreezeDark ;;
        *BreezeClassic*) plasma-apply-colorscheme BreezeDark ;;
        *openSUSE*) plasma-apply-colorscheme openSUSEdark ;;
        *openSUSEdark*) plasma-apply-colorscheme openSUSE ;;
    esac
fi
