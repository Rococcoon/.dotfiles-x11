#!/bin/bash
#
# By: LBRM

# Define variables
THEME_DIR="/usr/share/themes/scarlet-rice-01"
GREETER_CONF_DIR="/usr/share/lightdm/lightdm-gtk-greeter.conf.d"
REPO_DIR="$HOME/Rices/ScarletRice1"
THEME_SRC="$REPO_DIR/config/lightdm/scarlet-rice-01"
GREETER_CONF_SRC="$REPO_DIR/config/lightdm/01-scarlet-greeter.conf"

# Function to remove existing files or symlinks
remove_existing() {
  local target=$1
  if [ -L "$target" ] || [ -e "$target" ]; then
    echo "Removing existing $target"
    sudo rm -rf "$target"
  fi
}

# Remove old theme directory if it exists
remove_existing "$THEME_DIR"

# Remove old greeter config if it exists
remove_existing "$GREETER_CONF_DIR/01-scarlet-greeter.conf"

# Create new symlinks
echo "Creating symlink for theme..."
sudo ln -s "$THEME_SRC" "$THEME_DIR"

echo "Creating symlink for greeter config..."
sudo ln -s "$GREETER_CONF_SRC" "$GREETER_CONF_DIR/01-scarlet-greeter.conf"

# Confirmation message
echo "Scarlet-Rice theme and configuration installed successfully!"
