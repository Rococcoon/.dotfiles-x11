#!/bin/bash

# Function to check if node is installed
check_node_installed() {
  if command -v node &> /dev/null; then
    echo "Node.js is already installed."
    return 0
  else
    return 1
  fi
}

# Function to get the current node version
get_node_version() {
  if command -v node &> /dev/null; then
    node --version
  else
    echo "Node.js not found."
  fi
}

# Function to install node via Webi
install_node() {
  echo "Installing Node.js via Webi..."
  webi node
}

# Function to update node via Webi
update_node() {
  echo "Updating Node.js via Webi..."
  webi node
}

# Check if node is installed
if check_node_installed; then
  # Get the installed version
  installed_version=$(get_node_version)

  echo "Installed Node.js version: $installed_version"
  echo "Checking for updates..."

  # Update Node.js if necessary (you could add version comparison logic here)
  update_node
else
  # Install Node.js if it's not installed
  install_node

  # Verify installation
  if check_node_installed; then
    echo "Node.js installed successfully."
  else
    echo "Failed to install Node.js."
    exit 1
  fi
fi
