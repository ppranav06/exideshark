#!/bin/bash
# Arch Post-installation script

function change_mirrors(){
	sudo pacman -Sy reflector
	echo "[exideshark] Changing mirrors to India"
	sudo reflector --country India
	}
# Install multimedia codecs
function codecs(){
	echo "[exideshark] Getting all the multimedia codecs"
	sudo pacman -S --noconfirm --needed \
	  libva-intel-driver libva-vdpau-driver libva-utils \
	  libvdpau-va-gl libvdpau libva-mesa-driver mesa-vdpau \
	  gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good \
	  gst-plugins-ugly ffmpeg
}

function apps(){
# Install yay (AUR helper)
	sudo pacman -S git --noconfirm			#Getting git
	git clone https://aur.archlinux.org/yay		#Cloning the repo
	echo [exideshark] Installing yay AUR helper
	cd yay && makepkg -si				#making the package
	echo [exideshark] Installation of yay complete
	cd -

# Installing apps here 
	echo [exideshark] Installing the required apps
	yay -Sy --noconfirm --needed \
		bat \
		exa \
		neofetch \
		brave-browser \
		github-cli \
		code \
		android-tools \
		vlc
# Installing flatpak apps
	flatpak install com.stremio.Stremio com.raggesilver.Blackbox -y
	echo "[exideshark] Apps installation complete"
}

# Executing functions
change_mirrors	#changes mirrors to India
codecs		#installs multimedia codecs
apps		#install all necessary apps


echo "[exideshark] Post-installation complete."
exit 0
