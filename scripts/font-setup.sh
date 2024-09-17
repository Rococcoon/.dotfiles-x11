#!/bin/bash

# Set up script for fonts
# By: LBRM

# Define font directory and font URLs
FONT_DIR="$HOME/.local/share/fonts"
MONONOKI_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Mononoki.zip"
SYMBOLS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/NerdFontsSymbolsOnly.zip"
FONT_AWESOME_URL="https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip"
MONONOKI_ZIP="$FONT_DIR/Mononoki.zip"
SYMBOLS_ZIP="$FONT_DIR/Symbols.zip"
FONT_AWESOME_ZIP="$FONT_DIR/fontawesome.zip"

# Create font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download the Mononoki Nerd Font
echo "Downloading Mononoki Nerd Font..."
curl -fLo "$MONONOKI_ZIP" "$MONONOKI_URL"

# Download the Symbols Nerd Font
echo "Downloading Symbols Nerd Font..."
curl -fLo "$SYMBOLS_ZIP" "$SYMBOLS_URL"

# Download Font Awesome
echo "Downloading Font Awesome..."
curl -fLo "$FONT_AWESOME_ZIP" "$FONT_AWESOME_URL"

# Extract the downloaded fonts
echo "Extracting Mononoki Nerd Font..."
unzip -o "$MONONOKI_ZIP" -d "$FONT_DIR"
echo "Extracting Symbols Nerd Font..."
unzip -o "$SYMBOLS_ZIP" -d "$FONT_DIR"
echo "Extracting Font Awesome..."
unzip -o "$FONT_AWESOME_ZIP" -d "$FONT_DIR"

# Remove the zip files after extraction
echo "Cleaning up..."
rm "$MONONOKI_ZIP"
rm "$SYMBOLS_ZIP"
rm "$FONT_AWESOME_ZIP"

# Refresh the font cache
echo "Refreshing font cache..."
fc-cache -fv

echo "Mononoki, Symbols Nerd Fonts, and Font Awesome installed successfully."
