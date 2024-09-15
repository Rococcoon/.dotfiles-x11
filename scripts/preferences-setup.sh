#!/bin/bash

# Define the configuration file path
CONFIG_FILE="/etc/X11/xorg.conf.d/90-touchpad.conf"

# Create or overwrite the configuration file with natural scrolling settings
echo "Creating or updating $CONFIG_FILE to enable natural scrolling..."

sudo tee "$CONFIG_FILE" > /dev/null <<EOF
Section "InputClass"
    Identifier "My Touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "NaturalScrolling" "true"
EndSection
EOF

# Inform the user and restart X session to apply changes
echo "Natural scrolling enabled. Restart X session or reboot to apply changes."

# Optionally restart the X server (disruptive)
# Uncomment the line below if you want to automate the restart
# sudo systemctl restart display-manager

# Define the xprofile and xinitrc file paths
XPROFILE_FILE="$HOME/.xprofile"
XINITRC_FILE="$HOME/.xinitrc"

# Command to set key mapping
KEYMAP_CMD="setxkbmap -option caps:esc"

# Function to create or update .xprofile
configure_xprofile() {
    echo "Creating or updating $XPROFILE_FILE..."
    echo "$KEYMAP_CMD" > "$XPROFILE_FILE"
    echo "$XPROFILE_FILE has been updated."
}

# Function to create or update .xinitrc
configure_xinitrc() {
    echo "Creating or updating $XINITRC_FILE..."
    echo "$KEYMAP_CMD" > "$XINITRC_FILE"
    echo "exec i3" >> "$XINITRC_FILE"
    echo "$XINITRC_FILE has been updated."
}

# Check if the .xprofile file exists
if [ ! -f "$XPROFILE_FILE" ]; then
    configure_xprofile
else
    echo "$XPROFILE_FILE already exists. Updating it..."
    configure_xprofile
fi

# Check if the .xinitrc file exists
if [ ! -f "$XINITRC_FILE" ]; then
    configure_xinitrc
else
    echo "$XINITRC_FILE already exists. Updating it..."
    configure_xinitrc
fi

# Notify user
echo "Configuration complete. Restart your X session or reboot your system for changes to take effect."
