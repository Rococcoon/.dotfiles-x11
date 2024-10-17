#!/bin/bash

# Set up script for fonts
# By: LBRM

# Set the directories
NERD_FONTS_DIR="$HOME/.fonts/nerd-fonts"
MDI_FONTS_DIR="$HOME/.fonts/material-design-icons"
LOCAL_FONTS_DIR="$HOME/.local/share/fonts"

# URLs for the fonts
MONONOKI_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip"
MONONOKI_ZIP="Mononoki.zip"
MDI_FONT_URL="https://github.com/Templarian/MaterialDesign-Webfont/archive/refs/heads/master.zip"
MDI_ZIP="material-design-icons.zip"

# Create necessary directories if they don't exist
mkdir -p "$NERD_FONTS_DIR" "$MDI_FONTS_DIR" "$LOCAL_FONTS_DIR"

# Download Mononoki Nerd Font zip file
echo "Downloading Mononoki Nerd Font..."
curl -fLo "$NERD_FONTS_DIR/$MONONOKI_ZIP" "$MONONOKI_FONT_URL"

# Unzip Mononoki Nerd Font
echo "Unzipping Mononoki Nerd Font..."
unzip -o "$NERD_FONTS_DIR/$MONONOKI_ZIP" -d "$NERD_FONTS_DIR/Mononoki"

# Copy Mononoki font files to ~/.local/share/fonts
echo "Copying Mononoki fonts to ~/.local/share/fonts..."
cp "$NERD_FONTS_DIR/Mononoki"/*.ttf "$LOCAL_FONTS_DIR/"

# Download Material Design Icons zip file
echo "Downloading Material Design Icons font..."
curl -fLo "$MDI_FONTS_DIR/$MDI_ZIP" "$MDI_FONT_URL"

# Unzip Material Design Icons
echo "Unzipping Material Design Icons..."
unzip -o "$MDI_FONTS_DIR/$MDI_ZIP" -d "$MDI_FONTS_DIR/MaterialDesign"

# Copy Material Design Icons font to ~/.local/share/fonts
echo "Copying Material Design Icons font to ~/.local/share/fonts..."
cp "$MDI_FONTS_DIR/MaterialDesign/fonts"/*.ttf "$LOCAL_FONTS_DIR/"

# Update the font cache
echo "Updating font cache..."
fc-cache -fv

# Cleanup zip files
echo "Cleaning up zip files..."
rm "$NERD_FONTS_DIR/$MONONOKI_ZIP"
rm "$MDI_FONTS_DIR/$MDI_ZIP"

echo "Mononoki Nerd Font and Material Design Icons font installed successfully!"
