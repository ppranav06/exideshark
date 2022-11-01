#!/bin/bash


# Functions
check_root(){
	if [[ $USER != "root" ]]; then echo "WARNING: This script MUST be run as superuser by 'sudo'. Now Exiting... " 
	exit 1
	fi
}

change_hostname(){
	check_root
	hostnamectl set-hostname "ThinkPad-L450"
}

bashrc(){
echo $(cat bashrc.txt) >> ~/.bashrc
}



apps(){
check_root
# Installing apps
dnf install -y git bat exa vim neofetch vlc gnome-tweaks gnome-extensions-app papirus-icon-theme android-tools openssh openssl brave-browser code balena-etcher-electron gh
#NOTE: openssl is for GSconnect

# Installing Multimedia codecs
dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
dnf install -y lame\* --exclude=lame-devel
dnf group upgrade -y --with-optional Multimedia

# Flatpak apps
flatpak install stremio -y
}


restart(){
check_root
echo "Restart the system? (y/n)"
read response
if [[ response = "y" ]]; then
	sudo reboot
else
	exit 0
fi
}

# Declared all functions till now
# Now, actually executing every function one by one :)

change_hostname
bashrc
edit_conf
add_repo
apps
gnome-shell-extension-installer
#runuser -l pranav -c "extensions" #EXTENSIONS INSTALLATION IS A BIG DEAL CURRENTLY; cannot execute the function as a user
restart


