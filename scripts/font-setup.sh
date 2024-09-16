#!/bin/bash

# Set up script for fonts
# By: LBRM

# Define font directory and font URLs
FONT_DIR="$HOME/.local/share/fonts"
MONONOKI_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Mononoki.zip"
SYMBOLS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Symbols.zip"
MONONOKI_ZIP="$FONT_DIR/Mononoki.zip"
SYMBOLS_ZIP="$FONT_DIR/Symbols.zip"

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download the Mononoki Nerd Font
curl -fLo "$MONONOKI_ZIP" "$MONONOKI_URL"

# Download the Symbols Nerd Font
curl -fLo "$SYMBOLS_ZIP" "$SYMBOLS_URL"

# Extract the downloaded fonts
unzip -o "$MONONOKI_ZIP" -d "$FONT_DIR"
unzip -o "$SYMBOLS_ZIP" -d "$FONT_DIR"

# Remove the zip files after extraction
rm "$MONONOKI_ZIP"
rm "$SYMBOLS_ZIP"

# Refresh the font cache
fc-cache -fv

echo "Mononoki and Symbols Nerd Fonts installed successfully."
