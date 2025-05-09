#!/bin/bash

# INSTALL APPS ##############################################################

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -f

install_app() {
    local app_name="$1"
    local package_name="$2"
    local command="$3"

    echo ""
    echo "----------------------------------------------------- $app_name"
    echo ""

    if which $package_name >/dev/null 2>&1; then
        echo "$app_name is already installed"
    else
        echo "$command"
        $command
    fi
}

install_chrome() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo rm -rf google-chrome-stable_current_amd64.deb
}

install_vscode() {
    wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo dpkg -i vscode.deb
    sudo apt-get install -f
    sudo rm vscode.deb
}

install_flameshot() {
    sudo apt install flameshot -y
    # https://github.com/flameshot-org/flameshot/issues/2560#issuecomment-1223943716
    sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf
}

install_docker() {
    # Add Docker's official GPG key:
    sudo apt-get install ca-certificates curl -y
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

    # Install
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    sudo usermod -aG docker $USER
    newgrp docker
}

# List of apps to install (app_name, package_name, command)
apps=(

    # dpkg apps
    "Google Chrome" "google-chrome" "install_chrome"

    # apt apps
    "Git" "git" "sudo apt install git -y"
    "GNOME Control Center" "gnome-control-center" "sudo apt install gnome-control-center -y"
    "LibreOffice" "libreoffice" "sudo apt install libreoffice -y"
    "VLC Player" "vlc" "sudo apt install vlc -y"
    "Autokey" "autokey-gtk" "sudo apt install autokey-gtk -y"
    "Peek" "peek" "sudo apt install peek -y"
    "Flameshot" "flameshot" "install_flameshot"
    "VSCode IDE" "code" "install_vscode"
    "Docker" "docker" "install_docker"

    # snap apps
    "Postman" "postman" "sudo snap install postman"
)

# Iterate through the list and add each shortcut
length=${#apps[@]}
for ((i = 0; i < length; i += 3)); do
    APP_NAME="${apps[$i]}"
    PACKAGE_NAME="${apps[$i + 1]}"
    COMMAND="${apps[$i + 2]}"
    install_app "$APP_NAME" "$PACKAGE_NAME" "$COMMAND"
done

# ADD TO FAVORITES ##############################################################

# to see favorite apps `dconf read /org/gnome/shell/favorite-apps`

favorites="['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'code.desktop', 'code_code.desktop', 'com.uploadedlobster.peek.desktop', 'gnome-control-center.desktop', 'autokey-gtk.desktop']"
dconf write /org/gnome/shell/favorite-apps "$favorites"
