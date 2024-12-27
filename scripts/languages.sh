#!/bin/bash

echo ""
echo "----------------------------------------------------- Configure languages"
echo ""

# Install pinyin
sudo apt install ibus ibus-libpinyin -y
# if not started automatically: ibus-daemon -drx

# Add languages
LANGUAGES="[('xkb', 'us'), ('xkb', 'ua'), ('xkb', 'ru'), ('xkb', 'gr'), ('ibus', 'libpinyin')]"
gsettings set org.gnome.desktop.input-sources sources "$LANGUAGES"
# to list current languages: gsettings get org.gnome.desktop.input-sources sources
