#!/bin/bash

# to see favorite apps `dconf read /org/gnome/shell/favorite-apps`

sudo apt update
sudo apt upgrade

echo ""
echo "==================================================Git"
echo ""

if git --version; then
    echo "Git is already installed"
else
    echo "Install Git..."
    echo ""
    sudo apt install git-all
fi

echo ""
echo "==================================================Chrome"
echo ""

if google-chrome --version; then
    echo "Chrome browser is already installed"
else
    echo "Install Chrome browser..."
    echo ""
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo rm -rf google-chrome-stable_current_amd64.deb
fi

if ! (dconf read /org/gnome/shell/favorite-apps | grep google-chrome); then
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'google-chrome.desktop']"
fi

# echo ""
# echo "==================================================PyCharm"
# echo ""

# echo "Install PyCharm IDE..."
# echo ""
# sudo snap install pycharm-community --classic

# if ! (dconf read /org/gnome/shell/favorite-apps | grep pycharm)
# then gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'pycharm-community_pycharm-community.desktop']"
# fi

# echo ""
# echo "==================================================WebStorm"
# echo ""

# echo "Install WebStorm IDE"
# echo ""
# sudo snap install webstorm --classic

# if ! (dconf read /org/gnome/shell/favorite-apps | grep webstorm)
# then gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'webstorm_webstorm.desktop']"
# fi

# echo ""
# echo "==================================================Telegram"
# echo ""

# echo "Install Telegram"
# echo ""
# sudo snap install telegram-desktop

# if ! (dconf read /org/gnome/shell/favorite-apps | grep telegram)
# then gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'telegram-desktop_telegram-desktop.desktop']"
# fi

echo ""
echo "==================================================Gnome-control-center"
echo ""

if gnome-control-center --version; then
    echo "Gnome-control-center is already installed"
else
    echo "Install Gnome-control-center..."
    echo ""
    sudo apt install gnome-control-center
fi

echo ""
echo "==================================================LibreOffice"
echo ""

if libreoffice --version; then
    echo "LibreOffice is already installed"
else
    echo "Install LibreOffice..."
    echo ""
    sudo apt install libreoffice
fi

echo ""
echo "==================================================Flameshot"
echo ""

# command name for shortcut: `flameshot gui`

echo "Install Flameshot..."
echo ""
sudo snap install flameshot


echo ""
echo "==================================================VLC Player"
echo ""

if code --version; then
    echo "VLC Player is already installed"
else
    echo "Install VLC Player..."
    echo ""
    sudo apt install vlc
fi

echo ""
echo "==================================================VSCode"
echo ""

if code --version; then
    echo "VSCode IDE is already installed"
else
    echo "Install VSCode IDE..."
    echo ""
    sudo apt install code
fi


if ! (dconf read /org/gnome/shell/favorite-apps | grep code_code); then
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'code_code.desktop']"
fi

# echo ""
# echo "==================================================NodeJS"
# echo ""

# echo "Install NodeJS..."
# echo ""
# sudo snap install node --classic

# echo ""
# echo "==================================================Teams"
# echo ""

# echo "Install Microsoft Teams..."
# echo ""
# sudo snap install teams

# if ! (dconf read /org/gnome/shell/favorite-apps | grep teams.desktop); then
#     gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'teams.desktop']"
# fi

echo ""
echo "==================================================Postman"
echo ""

echo "Install Postman..."
echo ""
sudo snap install postman

if ! (dconf read /org/gnome/shell/favorite-apps | grep postman); then
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'postman_postman.desktop']"
fi

echo ""
echo "==================================================Autokey"
echo ""

if which autokey > /dev/null 2>&1; then
    echo "Autokey is already installed"
else
    echo "Install Autokey..."
    echo ""
    sudo apt install autokey-gtk -y
    sudo apt install --fix-broken
fi

echo ""
echo "================================================== SHORTCUTS"
echo ""

./shortcuts.sh


