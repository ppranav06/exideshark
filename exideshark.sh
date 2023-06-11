#!/bin/bash


# Functions
check_root(){
	if [[ $USER != "root" ]]; then 
		echo "WARNING: This script MUST be run as superuser by 'sudo'. Now Exiting... " 
		exit 1
	fi
}

change_hostname(){
	echo "[exideshark] What would you like to set as your hostname?"
	echo "HOSTNAME: "; read host_name
	sudo hostnamectl set-hostname $host_name
}

write_bashrc(){
	echo $(cat bashrc.txt) >> ~/.bashrc
}

function base_system_declaration(){
	# Check if /etc/debian_version exists
	if [ -f /etc/debian_version ]; then
		echo "[exideshark] Debian-based distribution detected."; DISTRO="debian"
	# Check if /etc/arch-release exists
	elif [ -f /etc/arch-release ]; then
		echo "[exideshark] Arch-based distribution detected."; DISTRO="arch"
	# Check if /etc/fedora-release exists
	elif [ -f /etc/fedora-release ]; then
		echo "[exideshark] Fedora-based distribution detected."; DISTRO="fedora"
	fi
}

function change_permissions(){
	# Change permissions to be executable for that distro
	chmod +x "./scripts/$DISTRO-install.sh"
	# Allow execution of extensions.sh
	chmod +x "./scripts/extensions.sh"
}

function installs(){
	if [[ $DISTRO == "arch" ]]; then 
		./scripts/arch-install.sh
	elif [[ $DISTRO == "fedora" ]]; then
		./scripts/fedora-install.sh
	elif [[ $DISTRO == "debian" ]]; then
		echo "[exideshark] Exideshark is not yet ready for Debian. Arriving soon."
	fi
}

function restart_now(){

	echo "[exideshark] Restart the system? (y/n)"
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
write_bashrc
base_system_declaration
change_permissions
installs
restart_now


