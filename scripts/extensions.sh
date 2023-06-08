#!/bin/bash
# Extensions installation and enabling

function extension_downloader(){
if [[ -e /usr/bin/gnome-shell-extension-installer ]]; then return
fi

# We use a shell script (https://github.com/brunelli/gnome-shell-extension-installer) to install multiple extensions altogether.

wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer #Executable
sudo mv gnome-shell-extension-installer /usr/bin/ #Added to root directory, so can be accessed anywhere
}

function install_extensions(){
# Installation of extensions 
extension_values=(1319 1460 517 615 3088 355 36 4245 19 1401 307)  #Array of extension values (Refer Jobs.md)
gnome-shell-extension-installer ${extension_values[*]}
gnome-shell-extension-installer ${extension_values[*]} #running again since it doesn't install in the first run

# Enabling extensions
gnome-extensions enable gsconnect@andyholmes.github.io \
	caffeine@patapon.info \
	appindicatorsupport@rgcjonas.gmail.com \
	status-area-horizontal-spacing@mathematical.coffee.gmail.com \
	Vitals@CoreCoding.com \
	extension-list@tu.berry \
	lockkeys@vaina.lt \
	gestureImprovements@gestures \
	bluetooth-quick-connect@bjarosze.gmail.com \
	drive-menu@gnome-shell-extensions.gcampax.github.com \
	places-menu@gnome-shell-extensions.gcampax.github.com \
	user-theme@gnome-shell-extensions.gcampax.github.com \
	dash-to-dock@micxgx.gmail.com 
}


# Executing functions
extension_downloader
install_extensions
