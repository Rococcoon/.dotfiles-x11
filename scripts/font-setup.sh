#!/bin/bash

# Set up script for fonts
# By: LBRM
# Run the script as root user

Define source and destination directories
SOURCE_DIR="$HOME/.dotfiles/ScarletRice1/fonts"
DEST_DIR="$HOME/.local/share/fonts"

Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory $SOURCE_DIR does not exist."
  exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

Copy fonts to destination directory, including subdirectories
echo "Copying fonts from $SOURCE_DIR to $DEST_DIR..."
if ! rsync -av "$SOURCE_DIR/" "$DEST_DIR/"; then
  echo "Failed to copy fonts."
  exit 1
fi

Update font cache
echo "Updating font cache..."
if ! fc-cache -fv; then
  echo "Failed to update font cache."
  exit 1
fi

echo "Nerd Fonts installation completed successfully."
