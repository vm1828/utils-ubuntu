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

install_flameshot() {
    sudo apt install flameshot -y
    # https://github.com/flameshot-org/flameshot/issues/2560#issuecomment-1223943716
    sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf
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

    # snap apps
    "Postman" "postman" "sudo snap install postman"
    "VS Code IDE" "code" "sudo snap install code --classic"
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

favorites="['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'code.desktop', 'com.uploadedlobster.peek.desktop', 'gnome-control-center.desktop', 'autokey-gtk.desktop']"
dconf write /org/gnome/shell/favorite-apps "$favorites"


