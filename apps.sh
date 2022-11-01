#!/bin/bash

# List of Packages

if [[ -e apt ]]; then DISTRO="debian"
elif [[ -e apt ]] && [[ -e snap ]]; then DISTRO="ubuntu"
elif [[ -e dnf ]]; then DISTRO="fedora"
elif [[ -e pacman ]]; then DISTRO="arch"
fi


if [[ $DISTRO == "fedora" ]]; then echo "git bat exa vim neofetch vlc gnome-tweaks gnome-extensions-app papirus-icon-theme android-tools openssh openssl brave-browser code balena-etcher-electron gh"

