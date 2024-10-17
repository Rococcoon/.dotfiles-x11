#!/bin/bash

# Exit on error
set -e

# Define variables
FONT_VERSION="2.1.0" # Change to the latest version
FONT_NAME="Shure Tech Mono"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${FONT_VERSION}/Shure%20Tech%20Mono.zip"
INSTALL_DIR="$HOME/.local/share/fonts"

# Create the fonts directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Download the font
echo "Downloading $FONT_NAME Nerd Font..."
curl -L -o "$INSTALL_DIR/Shure Tech Mono.zip" "$DOWNLOAD_URL"

# Unzip the font
echo "Installing $FONT_NAME Nerd Font..."
unzip -o "$INSTALL_DIR/Shure Tech Mono.zip" -d "$INSTALL_DIR"

# Clean up
echo "Cleaning up..."
rm "$INSTALL_DIR/Shure Tech Mono.zip"

# Update font cache
fc-cache -f -v

echo "$FONT_NAME Nerd Font has been installed!"
