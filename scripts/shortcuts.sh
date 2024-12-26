#!/bin/bash

echo "Add system shortcuts --------------------------------------------------"

MEDIA_KEYS="org.gnome.settings-daemon.plugins.media-keys"

# Reset all custom keybindings
echo "Resetting custom keybindings..."
gsettings set $MEDIA_KEYS custom-keybindings "[]"

# Function to add a shortcut
add_shortcut() {
    local shortcut_name="$1"
    local command="$2"
    local shortcut="$3"
    local keybinding_entry="$4"

    echo "Adding keybind entry: $keybinding_entry..."
    CUSTOM_KEYBINDINGS=$(gsettings get $MEDIA_KEYS custom-keybindings)
    if [[ $CUSTOM_KEYBINDINGS == "@as []" ]]; then
        UPDATED_KEYBINDINGS="['$keybinding_entry']"
    else
        UPDATED_KEYBINDINGS="${CUSTOM_KEYBINDINGS%?}, '$keybinding_entry']"
    fi
    gsettings set $MEDIA_KEYS custom-keybindings "$UPDATED_KEYBINDINGS"

    echo "Setting up new shortcut: $shortcut_name..."
    FULL_ENTRY="$MEDIA_KEYS.custom-keybinding:$keybinding_entry"
    gsettings set $FULL_ENTRY name "$shortcut_name"
    gsettings set $FULL_ENTRY command "$command"
    gsettings set $FULL_ENTRY binding "$shortcut"
}

# List of shortcuts to add (name, command, shortcut)
shortcuts=(
    "Flameshot_1" "flameshot gui" "<Super><Shift>S"
    "Flameshot_2" "flameshot gui" "<Super>J"
    # "Terminal" "gnome-terminal" "<Ctrl><Alt>T"
    # "Screenshot" "gnome-screenshot" "<Shift><Alt>S"
)

# Iterate through the list and add each shortcut
length=${#shortcuts[@]}
for ((i=0; i<length; i+=3)); do
    SHORTCUT_NAME="${shortcuts[$i]}"
    COMMAND="${shortcuts[$i+1]}"
    SHORTCUT="${shortcuts[$i+2]}"
    KEYBINDING_ENTRY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$((i/3))/"
    add_shortcut "$SHORTCUT_NAME" "$COMMAND" "$SHORTCUT" "$KEYBINDING_ENTRY"
done

echo "Setup Autokey ---------------------------------------------------------"

echo "Remove numpad keys bindings..."
# Home
xmodmap -e "keycode 180 = F13"
# mail
xmodmap -e "keycode 163 = F14"
# calc
xmodmap -e "keycode 148 = F15"

echo "Setup Autokey..."
rm -rf ~/.config/autokey
cp -rf ./scripts/autokey ~/.config/