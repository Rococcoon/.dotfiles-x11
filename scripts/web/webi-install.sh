#!/bin/bash

# Define the Webi installation URL and installation directory
WEBI_INSTALL_URL="https://webi.sh/webi"
WEBI_INSTALL_DIR="$HOME/.local/bin"

# Function to check if webi is installed
check_webi_installed() {
  if command -v webi &> /dev/null; then
    echo "Webi is already installed."
    return 0
  else
    return 1
  fi
}

# Function to get the current webi version
get_webi_version() {
  if command -v webi &> /dev/null; then
    webi --version
  else
    echo "Webi not found."
  fi
}

# Function to install webi
install_webi() {
  echo "Installing Webi..."
  curl -sS https://webi.sh/webi | sh
}

# Function to update webi if necessary
update_webi() {
  echo "Updating Webi..."
  webi webi
}

# Check if webi is installed
if check_webi_installed; then
  # Get the installed version
  installed_version=$(get_webi_version)

  echo "Installed version: $installed_version"
  echo "Checking for updates..."

  # Update Webi if necessary (you could add version comparison logic here)
  update_webi
else
  # Install Webi if it's not installed
  install_webi

  # Verify installation
  if check_webi_installed; then
    echo "Webi installed successfully."
  else
    echo "Failed to install Webi."
    exit 1
  fi
fi
