#!/bin/bash
# Fedora Specific actions for initial setup

if [[ $USER != "root"]]; then exit 1; fi

dnf_conf_edit(){
tee -a /etc/dnf/dnf.conf > /dev/null <<EOT
Fastestmirror=true
max_parallel_downloads=20
deltarpm=true
EOT
}


add_repo(){
    check_root
    # Adding non-free repositories
    dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    
    # Adding Flatpak Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    
    #VSCode
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    
    # Brave browser
    dnf install -y dnf-plugins-core
    dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
    rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    
    # Etcher
    curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/setup.rpm.sh' | sudo -E bash
    
    # GitHub CLI
    dnf install -y 'dnf-command(config-manager)'
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
}


apps(){
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

dnf_conf_edit
add_repo
apps