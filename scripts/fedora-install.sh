#!/bin/bash
# Fedora Post-installation script

#if [[ $USER != "root"]]; then exit 1; fi	#Execute only if root (deprecated)

function dnf_conf_edit(){
sudo tee -a /etc/dnf/dnf.conf > /dev/null <<EOT
Fastestmirror=true
max_parallel_downloads=20
deltarpm=true
EOT
}

function add_repo(){
    # Adding non-free repositories
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    
    # Adding Flatpak Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    
    #VSCode
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    
    # Brave browser
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

    # GitHub CLI
    sudo dnf install -y 'dnf-command(config-manager)'
    sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
}


function apps(){
	echo "[exideshark] Initiating app install"
    # Installing apps
    
    sudo dnf install -y git \
	    bat \
	    exa \
	    vim \
	    neofetch \
	    vlc \
	    gnome-tweaks \
	    gnome-extensions-app \
	    papirus-icon-theme \
	    android-tools \
	    openssh \
	    openssl \
	    brave-browser \
	    code \
	    balena-etcher-electron \
	    gh
    # NOTE: openssl is for GSconnect

    # Flatpak apps
    flatpak install com.stremio.Stremio com.raggesilver.BlackBox

    echo "[exideshark] Installed all apps" 
}

function codecs(){
    # Installing Multimedia codec 
    sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
    sudo dnf install -y lame\* --exclude=lame-devel
    sudo dnf group upgrade -y --with-optional Multimedia

    echo "[exideshark] Obtained all multimedia codecs"
}

# Execution of the functions
dnf_conf_edit	#Edit DNF config
add_repo	# Add required repos
sudo dnf update -y # Update the system
codecs		# Add multimedia codecs
apps		# Install all the apps


echo "[exideshark] Post-installation complete."
exit 0
